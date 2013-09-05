module Arel
  module Visitors
    class PostGIS < Arel::Visitors::ToSql
      private

      def visit_Arel_Nodes_Spatial_Function o
        "#{o.class.to_s.split('::').last}(#{o.expressions.map { |x| visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
      end

    end
  end
end