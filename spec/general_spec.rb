require_relative '../lib/minimal_markdown'

describe MinimalMarkdown do
  subject { MinimalMarkdown.render(text) }

  EXAMPLES = {
    '' => '',
    'simple text' => '<div>simple text</div>',
    '*bold*' => '<div><b>bold</b></div>',
    'simple *bold*' => '<div>simple <b>bold</b></div>',
    '_italic_ simple' => '<div><i>italic</i> simple</div>',
    "Two lines\n\nGood" => '<p>Two lines</p><div>Good</div>',
    '*_both_*' => '<div><b><i>both</i></b></div>',
    '3 * 5 * 7' => '<div>3 * 5 * 7</div>',
    'and * things *' => '<div>and * things *</div>',
    'and *things *' => '<div>and <b>things </b></div>',
    'and * things*' => '<div>and <b> things</b></div>',
    '*start* line' => '<div><b>start</b> line</div>',
    "\n\n  strips\n\n\n   " => '<div>strips</div>',
    "&" => '<div>&amp;</div>',
    "* 1\n* 2\n\n* 3\n" => '<ul><li>1</li><li>2</li></ul><ul><li>3</li></ul>',
    "* 1\n* 2\nwait a little\n\n* 3\n" => '<ul><li>1</li><li>2</li></ul><p>wait a little</p><ul><li>3</li></ul>',
  }

  EXAMPLES.each do |input, output|
    context input.inspect do
      let(:text) { input }

      it "renders as expected" do
        expect(subject).to eq output
      end
    end
  end

  context "a complicated example" do
    let(:text) do
      <<-EOT
Cheese is *good*.

* Cheese is interesting.
* Not very healthy.
* I like it though.
That's my thoughts.
      EOT
    end

    it "renders as expected" do
      expect(subject).to eq <<-EOT.strip
  <p>Cheese is <b>good</b>.</p><ul><li>Cheese is interesting.</li><li>Not very healthy.</li><li>I like it though.</li></ul><div>That&#39;s my thoughts.</div>
      EOT
    end
  end
end
