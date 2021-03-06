require "rouge"

module RDoc
  module Rouge
    class Formatter < ::RDoc::Markup::ToHtml

      def initialize(options={})
        opts = ::RDoc::Options.new
        opts.pipe = options.delete(:pipe) || false

        super opts, nil
      end

      def accept_verbatim verbatim
        text = verbatim.text.rstrip

        lexer = ::Rouge::Lexer.find_fancy(verbatim.format.to_s, text) || ::Rouge::Lexers::Text

        formatter = ::Rouge::Formatters::HTML.new(
          :css_class => "highlight #{lexer.tag}"
        )

        @res << formatter.format(lexer.lex(text))
      end
    end
  end
end
