module Emf
  module EmfPathBracket
    module ClassMethods #InstanceMethods
      [:emr_beginpath, :emr_endpath].each do |path|
        define_method(path) { |params| true }
      end
      [:emr_fillpath, :emr_strokepath, :emr_strokeandfillpath].each do |path|
        define_method(path) { |params| {:bounds => rect_l(params)} }
      end
    end

    def self.included(klass)
      klass.module_eval {  extend ClassMethods }
    end
  end
end
