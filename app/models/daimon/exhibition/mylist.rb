module Daimon
  module Exhibition
    # TODO Depends on `primary_key`, not an `id`.

    class Mylist
      class << self
        def load_from_serialized(serialized)
          new(serialized)
        end
      end

      def initialize(ids = nil)
        @ids = (ids || {}).with_indifferent_access
      end

      def serialize
        @ids.dup
      end

      def ids_by_type(type = nil)
        if type
          # To keep key for type.
          {type => []}.with_indifferent_access.merge(@ids.deep_dup)
        else
          @ids.deep_dup
        end
      end

      def count_of(type)
        @ids[type].count
      end

      def count
        @ids.values.flatten.count
      end

      def has_item?(type = nil)
        (type ? count_of(type) : count) > 0
      end

      def empty?
        !has_item?
      end

      def exhibits_of(type)
        Mapping.detect_exhibits_by(type).where(id: @ids[type])
      end

      def include?(item)
        ids_for(item).include?(item.id)
      end

      def add(item)
        ids_for(item).push(item.id) unless include?(item)
      end

      def delete(item)
        ids_for(item).delete(item.id)
      end

      def clear(type = nil)
        if type
          @ids[type]&.clear
        else
          @ids.clear
        end
      end

      private

      def ids_for(item)
        @ids[type_of(item)] ||= []
      end

      def type_of(item)
        Mapping.class_to_type(item.class)
      end
    end
  end
end
