module MinimalMarkdown
  class HtmlRenderer
    attr_reader :tree

    def initialize(tree)
      @tree = tree
    end

    def render
      output = ''
      tree.each { |node| node.render(output) }
      output
    end
  end
end
