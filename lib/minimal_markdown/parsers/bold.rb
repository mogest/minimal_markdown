module MinimalMarkdown::Parsers
  class Bold < Base
    def initialize(style)
      @regex = case style
      when :markdown then /(^|\W)(\*\*|__)(\S|\S.*?\S)\2(\W|$)/
      when :slack    then /(^|\W)(\*)(\S[^*]*|[^*]*\S)\*(\W|$)/
      end

      @node_class = ::MinimalMarkdown::Nodes::Bold
    end
  end
end
