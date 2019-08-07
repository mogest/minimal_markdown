require_relative 'minimal_markdown/version'
require_relative 'minimal_markdown/nodes'
require_relative 'minimal_markdown/implementors'
require_relative 'minimal_markdown/parser'
require_relative 'minimal_markdown/html_renderer'

module MinimalMarkdown
  def self.render(text)
    tree = MinimalMarkdown::Parser.new(text).parse
    MinimalMarkdown::HtmlRenderer.new(tree).render
  end
end
