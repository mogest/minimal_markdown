module MinimalMarkdown::Parsers
  class UnorderedList
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
          ::MinimalMarkdown::Nodes::Text.new(line.gsub(/^\s*\*\s+/, ''))
        end
        out << ::MinimalMarkdown::Nodes::UnorderedList.new(children)

        input = result.post_match
      end

      out << input unless input.empty?
      out
    end
  end
end
