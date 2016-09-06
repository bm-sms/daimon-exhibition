module Daimon
  module Exhibition
    module MylistSupport
      def acts_as_mylist(exhibit_type, exhibit_scope)
        include MylistController

        enable_to_read_mylist
        enable_to_write_mylist

        define_method :exhibit_type do
          exhibit_type
        end

        define_method :exhibit_scope, &exhibit_scope
      end

      def enable_to_read_mylist
        include MylistReadable

        helper_method :mylist
      end

      def enable_to_write_mylist
        include MylistWritable

        after_action :store_mylist, only: %i(create destroy destroy_all)

        enable_to_read_mylist
      end

      module MylistReadable
        protected

        def mylist
          @mylist ||= restore_mylist
        end

        private

        def restore_mylist
          ::Daimon::Exhibition::Mylist.load_from_serialized(session[:mylist])
        end
      end

      module MylistWritable
        include MylistReadable

        private

        def store_mylist
          session[:mylist] = mylist.serialize
        end
      end

      module MylistController
        include MylistReadable
        include MylistWritable

        def index
          @exhibits = exhibit_scope.merge(mylist.exhibits_of(exhibit_type))

          assign_exhibits_variable @exhibits
          assign_inquiry_variable @exhibits if has_inquiry?

          respond_to do |format|
            format.html
            format.json { render_mylist_as_json }
          end
        end

        def create
          item = exhibit_scope.find(params[:id])

          mylist.add item

          respond_to do |format|
            format.html { redirect_back fallback_location: item }
            format.json { render_mylist_as_json status: :created }
          end
        end

        def destroy
          item = exhibit_scope.find_by(id: params[:id])

          mylist.delete item if item

          respond_to do |format|
            format.html { redirect_back fallback_location: item }
            format.json { render_mylist_as_json }
          end
        end

        def destroy_all
          mylist.clear(exhibit_type)

          respond_to do |format|
            format.html { redirect_back fallback_location: :root }
            format.json { render_mylist_as_json }
          end
        end

        private

        def inquiry_class
          ::Daimon::Exhibition::Mapping.detect_inquiry_by(exhibit_type)
        end

        def inquiry_type
          ::Daimon::Exhibition::Mapping.detect_inquiry_type_by(exhibit_type)
        end

        def has_inquiry?
          inquiry_class.present?
        end

        def assign_exhibits_variable(exhibits)
          instance_variable_set "@#{exhibits.model_name.collection}", exhibits
        end

        def assign_inquiry_variable(exhibits)
          @inquiry = inquiry_class.new(inquiry_class.exhibit_writer_for(exhibit_type) => exhibits.ids)

          instance_variable_set "@#{inquiry_type}", @inquiry
        end

        def render_mylist_as_json(options = {})
          render options.merge(json: mylist.ids_by_type(exhibit_type))
        end
      end
    end
  end
end
