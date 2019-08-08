module MinimalMarkdown::Parsers
  class Bold < Base
    def initialize
      @regex = /(^|\W)\*(\S[^*]*|[^*]*\S)\*(\W|$)/
      @node_class = ::MinimalMarkdown::Nodes::Bold
    end
  end
end
