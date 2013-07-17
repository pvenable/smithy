require "smithy/container"

module Smithy
  module ServiceLocator
    class << self
      attr_reader :container

      def included(base)
        base.extend(ClassMethods)
      end

      def register_container(container)
        @container = container
      end
    end

    module ClassMethods
      private

      def dependency(name)
        define_method name do
          ServiceLocator.container.instance(name)
        end

        private name
      end
    end
  end
end
