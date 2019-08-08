module MinimalMarkdown::Nodes
  Bold = Struct.new(:child) do
    def render(output)
      output << '<b>'
      child.render(output)
      output << '</b>'
    end
  end
end
