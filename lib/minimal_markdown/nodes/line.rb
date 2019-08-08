module MinimalMarkdown::Nodes
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
end
