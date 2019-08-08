module MinimalMarkdown::Nodes
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
end
