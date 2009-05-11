module Emf
  module EmfDraw
    module ClassMethods
      [:emr_polygon16,
       :emr_polyline16,
       :emr_polylineto16,
       :emr_polybezier16,
       :emr_polybezierto16 ].each do |polygon_method|
        define_method(polygon_method) { |params| parse_poly_params(params,:point_s) }
      end


      [:emr_polygon,
       :emr_polyline,
       :emr_polylineto,
       :emr_polybezier,
       :emr_polybezierto ].each do |polygon_method|
        define_method(polygon_method) { |params| parse_poly_params(params,:point_l) }
      end

      [:emr_lineto].each do |method|
        define_method(method) { |params| {:points => point_l(params) } }
      end


      def emr_anglearc params
        {
          :bounds => point_l(params),
          :center => params[8..11].unpack("I").first,
          :start_angle => params[12..15].unpack("I").first,
          :end_angle => params[15..19].unpack("I").first
        }
      end


      [:emr_arc, :emr_arcto,:emr_chord].each do |method|
        define_method(method) do |params|
          return nil if params.size < 31
          {
            :box   => rect_l(params),
            :start => point_l(params[16..23]),
            :end   => point_l(params[24..31])
          }
        end
      end

      def emr_ellipse params
        return nil if params.size < 15
        {:box => rect_l(params)}
      end
      def emr_extfloodfill params
        { :start => point_l(params),
          :color => color_ref(params[8..11]),
          :floodfillmode => params[12..15].unpack("I").first }
      end

      def emr_polydraw params
        parse_poly_draw(params,:point_l)
      end
      def emr_polydraw16 params
        parse_poly_draw(params,:point_s)
      end
   end

    def self.included(klass)
      klass.module_eval do
        #include InstanceMethods
        extend ClassMethods
      end
    end
  end

end
