module MinimalMarkdown::Parsers
  class Italic < Base
    def initialize(style)
      @regex = case style
      when :markdown then /(^|\W)([_*])(?!\2)(\S|\S.*?(?!\2)\S)\2(\W|$)/
      when :slack    then /(^|\W)(_)(\S[^_]*|[^_]*\S)_(\W|$)/
      end

      @node_class = ::MinimalMarkdown::Nodes::Italic
    end
  end
end
