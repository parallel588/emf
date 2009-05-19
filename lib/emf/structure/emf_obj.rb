module Emf
  module EmfObj
    module ClassMethods
      def usingned_integer params
        params.unpack("V").first
      end
      alias :us_int  :usingned_integer

      def points(count,params,type= :point_s)
        case type
        when :point_s
          (0..count-1).map { |x| self.point_s(params[4*x..4*x+3]) }
        when :point_l
          (0..count-1).map { |x|  self.point_l(params[8*x..8*x+7]) }
        when :us_int
          (0..count-1).map { |x|  self.us_int(params[4*x..4*x+3]) }
        end
      end

      def parse_poly_draw(params, type = :point_s)
        @points = []
        @type_points = []
        @count = self.us_int(params[16..19])

        @offset_type_points=  case type
                              when :point_s then @offset_type_points = 20+@count*4
                              when :point_l then @offset_type_points = 20+@count*8
                              end
        @points = self.points(@count,params[20..(@offset_type_points-1)],type)
        @type_points = (0..@count-1).map { |x| params[@offset_type_points+x] }

        {
          :bounds =>  self.rect_l(params),
          :count_points =>@count,
          :points => @points,
          :type_points => @type_points
        }
      end
      def parse_poly_params(params, type = :point_s)
        @count_points = self.us_int(params[16..19])
        @points = self.points(@count_points,params[20..-1],type)
        { :bounds =>  self.rect_l(params),
          :count_points => @count_points,
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

      def size_l(b)
        [self.us_int(b[0..3]),self.us_int(b[4..7])]
      end
      def color_ref b
        [b[0],b[1],b[2]]
        # Red (1 byte):
        # Green (1 byte):
        # Blue (1 byte):
        # Reserved (1 byte):
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
