module Daimon
  module Exhibition
    module Exhibit
      def acts_as_exhibit(to: :inquiry)
        define_method "#{to}_params" do
          {__send__("#{to}_key") => [__send__(self.class.primary_key)]}
        end

        define_method "#{to}_key" do
          inquiry_class = ::Daimon::Exhibition::Mapping.detect_inquiry_by(self.class)
          type          = ::Daimon::Exhibition::Mapping.class_to_type(self.class)

          inquiry_class.exhibit_writer_for(type)
        end

        ::Daimon::Exhibition::Mapping.register(self, to)
      end
    end
  end
end
