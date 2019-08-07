require 'cgi'

module MinimalMarkdown
  UnorderedList = Struct.new(:children) do
    def render(output)
      output << '<ul>'
      children.each do |child|
        output << '<li>'
        child.render(output)
        output << '</li>'
      end
      output << '</ul>'
    end
  end

  Line = Struct.new(:child, :spacing) do
    def render(output)
      if spacing < 2
        output << '<div>'
        child.render(output)
        output << '</div>'
      else
        output << '<p>'
        child.render(output)
        output << '</p>'
        if spacing > 2
          output << '<br>' * (spacing - 2)
        end
      end
    end
  end

  Text = Struct.new(:text) do
    def render(output)
      if text.is_a?(Array)
        text.each { |child| child.render(output) }
      else
        output << CGI.escapeHTML(text)
      end
    end
  end

  Bold = Struct.new(:child) do
    def render(output)
      output << '<b>'
      child.render(output)
      output << '</b>'
    end
  end

  Italic = Struct.new(:child) do
    def render(output)
      output << '<i>'
      child.render(output)
      output << '</i>'
    end
  end
end
