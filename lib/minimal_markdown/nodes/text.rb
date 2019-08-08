require 'cgi'

module MinimalMarkdown::Nodes
  Text = Struct.new(:text) do
    def render(output)
      if text.is_a?(Array)
        text.each { |child| child.render(output) }
      else
        output << CGI.escapeHTML(text)
      end
    end
  end
end
