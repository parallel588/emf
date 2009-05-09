module Emf
  module EmfDraw
    module ClassMethods
      [:emr_polygon16, :emr_polyline16,:emr_polylineto16,
       :emr_polybezier16, :emr_polybezierto16 ].each do |polygon_method|
        define_method(polygon_method) { |params| parse_poly_params(params) }
      end
      [:emr_lineto, :emr_movetoex].each do |method|
        define_method(method) { |params| point_l(params) }
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
