require_relative 'minimal_markdown/version'
require_relative 'minimal_markdown/nodes/bold'
require_relative 'minimal_markdown/nodes/italic'
require_relative 'minimal_markdown/nodes/line'
require_relative 'minimal_markdown/nodes/text'
require_relative 'minimal_markdown/nodes/unordered_list'
require_relative 'minimal_markdown/parsers/base'
require_relative 'minimal_markdown/parsers/bold'
require_relative 'minimal_markdown/parsers/italic'
require_relative 'minimal_markdown/parsers/unordered_list'
require_relative 'minimal_markdown/parser'
require_relative 'minimal_markdown/html_renderer'

module MinimalMarkdown
  def self.render(text)
    tree = MinimalMarkdown::Parser.new(text).parse
    MinimalMarkdown::HtmlRenderer.new(tree).render
  end
end
