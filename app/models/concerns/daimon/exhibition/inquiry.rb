module Daimon
  module Exhibition
    module Inquiry
      def acts_as_inquiry(to: , via: nil)
        extend Writier

        via ||= "#{to}_ids"
        exhibits_writers[to] = via.to_sym
      end

      module Writier
        def exhibit_writer_for(type)
          exhibits_writers[type]
        end

        private

        def exhibits_writers
          @exhibits_writers ||= {}
        end
      end
    end
  end
end
