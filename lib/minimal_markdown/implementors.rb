module MinimalMarkdown
  class ImplementorBase
    def multiline?
      false
    end

    def update_tree(tree)
      tree.each { |node| update_node(node) }
    end

    private

    def update_node(node)
      if node.is_a?(Text)
        if node.text.is_a?(Array)
          update_tree(node.text)
        else
          out = []
          input = node.text
          while result = input.match(@regex)
            out << Text.new(result.pre_match + result[1]) unless result.pre_match.empty?
            out << @node_class.new(Text.new(result[2]))
            input = result[3] + result.post_match
          end

          if !out.empty?
            out << Text.new(input) unless input.empty?
            node.text = out
          end
        end
      elsif node.respond_to?(:children)
        update_tree(node.children)
      else
        update_node(node.child)
      end
    end
  end

  class BoldImplementor < ImplementorBase
    def initialize
      @regex = /(^|\W)\*(\S[^*]*|[^*]*\S)\*(\W|$)/
      @node_class = Bold
    end
  end

  class ItalicImplementor < ImplementorBase
    def initialize
      @regex = /(^|\W)_(\S[^_]*|[^_]*\S)_(\W|$)/
      @node_class = Italic
    end
  end

  class UnorderedListImplementor
    def multiline?
      true
    end

    def update_tree(tree)
      tree.flat_map do |node|
        if node.is_a?(String)
          update_text(node)
        else
          node
        end
      end
    end

    private

    def update_text(input)
      out = []

      while result = input.match(/(?:^[ ]*\*[ ]+[^\n]+(?:\n|$))+/m)
        out << result.pre_match unless result.pre_match.empty?

        children = result[0].split("\n").map do |line|
          Text.new(line.gsub(/^\s*\*\s+/, ''))
        end
        out << UnorderedList.new(children)

        input = result.post_match
      end

      out << input unless input.empty?
      out
    end
  end
end
