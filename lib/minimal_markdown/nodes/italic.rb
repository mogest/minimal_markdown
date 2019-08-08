module MinimalMarkdown::Nodes
  Italic = Struct.new(:child) do
    def render(output)
      output << '<i>'
      child.render(output)
      output << '</i>'
    end
  end
end
