require 'cgi'

module MinimalMarkdown
  class Parser
    DEFAULT_PARSERS = [
      Parsers::UnorderedList,
      Parsers::Bold,
      Parsers::Italic,
    ]

    attr_reader :text, :parsers

    def initialize(text, parsers: DEFAULT_PARSERS)
      @text = text
      @parsers = parsers
    end

    def parse
      prepared_text = text.strip.gsub("\r", "")

      preline_parsers, postline_parsers = parsers.map(&:new).partition(&:multiline?)

      preline_tree = run_parsers(preline_parsers, [prepared_text])
      postline_tree = convert_to_lines(preline_tree)
      run_parsers(postline_parsers, postline_tree)
    end

    private

    def run_parsers(parsers, input_tree)
      parsers.inject(input_tree) do |tree, parser|
        parser.update_tree(tree)
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
          Nodes::Line.new(Nodes::Text.new(line), spaces&.count("\n") || 0)
        end
      end
    end
  end
end
