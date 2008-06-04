module Spec
  module Rails
    module Matchers
      def conform_to_dtd(filename)
        return simple_matcher("xml to confirm to dtd #{filename}") do |xml|
          dtd = nil
          File.open(filename, 'r') do |f|
            dtd = XML::Dtd.new(f.read)
          end

          document = XML::Parser.string(xml).parse
          document.validate(dtd)
        end
      end
    end
  end
end