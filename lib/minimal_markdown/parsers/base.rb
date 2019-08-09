module MinimalMarkdown::Parsers
  class Base
    def multiline?
      false
    end

    def update_tree(tree)
      tree.each { |node| update_node(node) }
    end

    private

    def update_node(node)
      if node.is_a?(::MinimalMarkdown::Nodes::Text)
        if node.text.is_a?(Array)
          update_tree(node.text)
        else
          out = []
          input = node.text
          while result = input.match(@regex)
            out << ::MinimalMarkdown::Nodes::Text.new(result.pre_match + result[1]) unless result.pre_match.empty?
            out << @node_class.new(::MinimalMarkdown::Nodes::Text.new(result[3]))
            input = result[4] + result.post_match
          end

          if !out.empty?
            out << ::MinimalMarkdown::Nodes::Text.new(input) unless input.empty?
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
end
