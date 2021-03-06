module ActiveAdmin
  module Helpers
    module Collection
      # 1. removes `select` and `order` to prevent invalid SQL
      # 2. correctly handles the Hash returned when `group by` is used
      def collection_size(c = collection)
        if defined?(ActiveRecord)
          c = c.except :select, :order
          c.group_values.present? ? c.count.count : c.count
        elsif defined?(Mongoid)
          if Kaminari::PaginatableArray === c
            c.count
          else
            c.count(true)
          end
        end
      end

      def collection_is_empty?(c = collection)
        collection_size(c) == 0
      end
    end
  end
end
