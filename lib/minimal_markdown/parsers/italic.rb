module MinimalMarkdown::Parsers
  class Italic < Base
    def initialize
      @regex = /(^|\W)_(\S[^_]*|[^_]*\S)_(\W|$)/
      @node_class = ::MinimalMarkdown::Nodes::Italic
    end
  end
end
