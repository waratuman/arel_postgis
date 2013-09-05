module Arel
  module Nodes
    module Spatial
      class Operator < Arel::Nodes::InfixOperation
      end

      class Intersection < Operator
        def initialize left, right
          super('&&', left, right)
        end
      end

      class Intersection3D < Operator
        def initialize left, right
          super('&&&', left, right)
        end
      end

      class OverLeft < Operator
        def initialize left, right
          super('&<', left, right)
        end
      end

      class OverBelow < Operator
        def initialize left, right
          super('&<|', left, right)
        end
      end

      class OverRight < Operator
        def initialize left, right
          super('&>', left, right)
        end
      end

      class Left < Operator
        def initialize left, right
          super('<<', left, right)
        end
      end

      class Below < Operator
        def initialize left, right
          super('<<|', left, right)
        end
      end

      class Equal < Operator
        def initialize left, right
          super('=', left, right)
        end
      end

      class Right < Operator
        def initialize left, right
          super('>>', left, right)
        end
      end
      
      class Contained < Operator
        def initialize left, right
          super('@', left, right)
        end
      end
      
      class OverAbove < Operator
        def initialize left, right
          super('|&>', left, right)
        end
      end

      class Above < Operator
        def initialize left, right
          super('|>>', left, right)
        end
      end
      
      class Contains < Operator
        def initialize left, right
          super('~', left, right)
        end
      end

      class Same < Operator
        def initialize left, right
          super('~=', left, right)
        end
      end

      class Distance < Operator
        def initialize left, right
          super('<->', left, right)
        end
      end

      class BoundingBoxDistance < Operator
        def initialize left, right
          super('<#>', left, right)
        end
      end

    end
  end
end