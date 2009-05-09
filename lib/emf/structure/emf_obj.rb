module Emf
  module EmfObj
    module ClassMethods
      def parse_poly_params params
        @points = []
        (params[16..19].unpack("V").first).times { |c|  @points << self.point_s(params[c*4+20..c*4+23]) }
        { :bounds =>  self.rect_l(params),
          :count_points => params[16..19].unpack("V").first,
          :points => @points
        }
      end

      def xform b
        point( [b[0..3],b[4..7],b[8..11],b[12..15],b[16..19],b[20..23]],'F')
      end

      def rect_l b
        point([b[0..3],b[4..7],b[8..11],b[12..15]],"I")
      end

      def point_s b
        self.point([b[0..1],b[2..3]],"v")
      end
      def point_l(b)
        self.point([b[0..3],b[4..7]],"I")
      end

      def point(b,f)
        b.map { |x| x.unpack(f).first}
      end
    end

    def self.included(klass)
      klass.module_eval do
      #       include InstanceMethods
        extend ClassMethods
      end
    end
  end
end

#   module InstanceMethods
#     def a
#       p "a"
#     end
#   end
#   module ClassMethods
#     def b
#       p "b"
#     end
#   end
#   def self.included(klass)
#     klass.module_eval do
#       include InstanceMethods
#       extend ClassMethods
#     end
#   end
