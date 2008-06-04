module Spec
  module Rails
    module Matchers
      def conform_to_dtd(filename)
        return simple_matcher("xml to confirm to dtd #{filename}") do |xml|
          validate_from_xsd_or_dtd(xml, filename) do |file_contents|
            XML::Dtd.new(file_contents)
          end
        end
      end
      
      def conform_to_xsd(filename)
        return simple_matcher("xml to confirm to dtd #{filename}") do |xml|
          validate_from_xsd_or_dtd(xml, filename) do |file_contents|
            #raise file_contents.to_s
            XML::Schema.from_string(file_contents)
          end
        end
      end
      
      private
      def validate_from_xsd_or_dtd(xml, filename)
        dtd = nil
        File.open(filename, 'r') do |f|
          dtd = yield f.read
        end

        document = XML::Parser.string(xml).parse
        !! document.validate(dtd)
      end
    end
  end
end