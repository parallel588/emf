module Emf
  module EmfTransform
    module ClassMethods
      def emr_modifyworldtransform params
        { :xform => xform(params),
          :mode =>  params[-4..-1].unpack("V").first}
      end
    end

    def self.included(klass)
      klass.module_eval { extend ClassMethods }
    end
  end
end
