require 'cgi'

module MinimalMarkdown
  class Parser
    DEFAULT_IMPLEMENTORS = [
      UnorderedListImplementor,
      BoldImplementor,
      ItalicImplementor
    ]

    attr_reader :text, :implementors

    def initialize(text, implementors: DEFAULT_IMPLEMENTORS)
      @text = text
      @implementors = implementors
    end

    def parse
      prepared_text = text.strip.gsub("\r", "")

      preline_implementors, postline_implementors = implementors.map(&:new).partition(&:multiline?)

      preline_tree = run_implementors(preline_implementors, [prepared_text])
      postline_tree = convert_to_lines(preline_tree)
      run_implementors(postline_implementors, postline_tree)
    end

    private

    def run_implementors(implementors, input_tree)
      implementors.inject(input_tree) do |tree, implementor|
        implementor.update_tree(tree)
      end
    end

    def convert_to_lines(tree)
      tree.flat_map do |node|
        if node.is_a?(String)
          parse_lines(node)
        else
          node
        end
      end
    end

    def parse_lines(text)
      text.scan(/(.*)(\s*\n)*/).flat_map do |line, spaces|
        if line.empty?
          []
        else
          Line.new(Text.new(line), spaces&.count("\n") || 0)
        end
      end
    end
  end
end
