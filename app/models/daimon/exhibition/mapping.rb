module Daimon
  module Exhibition
    module Mapping
      class << self
        def register(klass, inquiry_type)
          mapping[klass] = inquiry_type
        end

        def detect_inquiry_by(type)
          inquiry_type = detect_inquiry_type_by(type)

          type_to_class(inquiry_type)
        end

        def detect_inquiry_type_by(type)
          klass =
            case type
            when Symbol
              type_to_class(type)
            when Class
              type
            else
              nil
            end

          raise "The exhibit class `#{type}` is missing." unless klass

          inquiry_type = mapping[klass]
          raise "The inquiry class for `#{type.inspect}` is missing. The registered exhibit types are: (#{mapping.keys.join(', ')})" unless inquiry_type

          inquiry_type
        end

        def detect_exhibits_by(type)
          raise "Unregistered exhibit type: `#{type.inspect}`. The registered exhibit types are: (#{mapping.keys.join(', ')})" unless mapping.keys.any? {|klass| klass.model_name.param_key == type.to_s }

          type_to_class(type)
        end

        def class_to_type(klass)
          klass.model_name.param_key.to_sym
        end

        def type_to_class(type)
          type.to_s.classify.safe_constantize
        end

        private

        def mapping
          @mapping ||= {}
        end
      end
    end
  end
end
