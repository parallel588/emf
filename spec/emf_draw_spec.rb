require File.dirname(__FILE__) + '/spec_helper'

class TestEmf
  include Emf::EmfDraw
  include Emf::EmfObj
end
describe EmfDraw do
  [
   :emr_anglearc, :emr_arc,  :emr_arcto, :emr_chord, :emr_ellipse, :emr_extfloodfill, :emr_exttextouta,
   :emr_exttextoutw, :emr_fillpath,  :emr_fillrgn,  :emr_framergn, :emr_gradientfill, :emr_lineto,
   :emr_paintrgn, :emr_pie,  :emr_polybezier, :emr_polybezier16, :emr_polybezierto, :emr_polybezierto16,
   :emr_polydraw,  :emr_polydraw16, :emr_polygon,  :emr_polygon16, :emr_polyline,  :emr_polyline16,
   :emr_polylineto, :emr_polylineto16, :emr_polypolygon, :emr_polypolygon16, :emr_polypolyline,
   :emr_polypolyline16, :emr_polytextouta,  :emr_polytextoutw,  :emr_rectangle, :emr_roundrect,
   :emr_setpixelv, :emr_smalltextout, :emr_strokeandfillpath, :emr_strokepath,
  ].each   do |method|
    it "Должен быть определен след. метод #{method}" do
      TestEmf.respond_to?(method.to_sym).should be_true
    end
  end


  it "метод emr_anglearc  должен вернуть список параметров: Center[], Radius, StartAngle,SweepAngle" do
    @returning_param = TestEmf.emr_anglearc("000000000000000000000000000000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:bounds].is_a?(Array).should be_true
    @returning_param[:bounds].should == [808464432,808464432]
    [:center, :start_angle, :end_angle].each do |p|
      @returning_param[p].is_a?(Fixnum).should be_true
      @returning_param[p].should == 808464432
    end
  end

  it "метод emr_arc должен вернуть Box(rect_l), Start(point_l), End(point_l)" do
    @returning_param = TestEmf.emr_arc("00000000000000000000000000000000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:box].is_a?(Array).should be_true
    @returning_param[:box].should == [808464432,808464432,808464432,808464432]
    [:start, :end].each do |p|
      @returning_param[p].is_a?(Array).should be_true
      @returning_param[p].should == [808464432,808464432]
    end

  end

  it "метод emr_arcto должен вернуть Box(rect_l), Start(point_l), End(point_l)" do
    @returning_param = TestEmf.emr_arcto("00000000000000000000000000000000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:box].is_a?(Array).should be_true
    @returning_param[:box].should == [808464432,808464432,808464432,808464432]
    [:start, :end].each do |p|
      @returning_param[p].is_a?(Array).should be_true
      @returning_param[p].should == [808464432,808464432]
    end
  end

  it "метод emr_chord должен вернуть Box(rect_l), Start(point_l),End(point_l)" do
    @returning_param = TestEmf.emr_chord("00000000000000000000000000000000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:box].is_a?(Array).should be_true
    @returning_param[:box].should == [808464432,808464432,808464432,808464432]
    [:start, :end].each do |p|
      @returning_param[p].is_a?(Array).should be_true
      @returning_param[p].should == [808464432,808464432]
    end
  end

  it "метод emr_ellipse должен венуть Box(rect_l)" do
    @returning_param = TestEmf.emr_ellipse("0000000000000000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:box].is_a?(Array).should be_true
    @returning_param[:box].should == [808464432,808464432,808464432,808464432]
  end

  it "метод emr_extfloodfill должен вернуть Start(point_l), Color(ColorRef), FloodFillMode(I)" do
    @returning_param = TestEmf.emr_extfloodfill("00000000Y0\0230\000\000\000\000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:start].is_a?(Array).should be_true
    @returning_param[:start].should == [808464432,808464432]

    @returning_param[:color].is_a?(Array).should be_true
    @returning_param[:color].should == [89,48,19]

    @returning_param[:floodfillmode].is_a?(Fixnum).should be_true
    @returning_param[:floodfillmode].should == 0x00000000

  end


  it "emr_lineto" do
    @returning_param = TestEmf.emr_lineto("\000\000\000\000\000\000\000\000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:points].is_a?(Array).should be_true
    @returning_param[:points].should == [0,0]
  end

  [:emr_polygon16,
   :emr_polyline16,
   :emr_polylineto16,
   :emr_polybezier16,
    :emr_polybezierto16].each do |m|
    it "#{m} Bounds, CountPoints, Points" do
      @returning_param =  TestEmf.send(m,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\003\000\000\000\000\000\000\000\n\000\n\000\f\000\f\000")
      @returning_param.is_a?(Hash).should be_true
      @returning_param[:bounds].is_a?(Array).should be_true
      @returning_param[:bounds].should == [0,0,12,12]
      @returning_param[:count_points].is_a?(Fixnum).should be_true
      @returning_param[:count_points].should == 3
      @returning_param[:points].is_a?(Array).should be_true
      @returning_param[:points].should == [[0,0],[10,10],[12,12]]
    end
  end

  [:emr_polygon,
   :emr_polyline,
   :emr_polylineto,
   :emr_polybezier,
   :emr_polybezierto].each do |m|
    it "#{m} Bounds, CountPoints, PointL" do
      @returning_param =  TestEmf.send(m,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\003\000\000\000\000\000\000\000\000\000\000\000\n\000\000\000\n\000\000\000\f\000\000\000\f\000\000\000")

      @returning_param.is_a?(Hash).should be_true
      @returning_param[:bounds].is_a?(Array).should be_true
      @returning_param[:bounds].should == [0,0,12,12]
      @returning_param[:count_points].is_a?(Fixnum).should be_true
      @returning_param[:count_points].should == 3
      @returning_param[:points].is_a?(Array).should be_true
      @returning_param[:points].should == [[0,0],[10,10],[12,12]]
    end
  end

  it "emr_polydraw" do
    @returning_param = TestEmf.emr_polydraw("\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\003\000\000\000\000\000\000\000\000\000\000\000\n\000\000\000\n\000\000\000\f\000\000\000\f\000\000\000\000\000\000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:bounds].is_a?(Array).should be_true
    @returning_param[:bounds].should == [0,0,12,12]
    @returning_param[:points].is_a?(Array).should be_true
    @returning_param[:points].should ==  [[0,0],[10,10],[12,12]]
    @returning_param[:type_points].is_a?(Array).should be_true
    @returning_param[:type_points].should ==  [0,0,0]
  end
  it "emr_polydraw16" do
  @returning_param = TestEmf.emr_polydraw16("\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\003\000\000\000\000\000\000\000\n\000\n\000\f\000\f\000\002\002\002")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:bounds].is_a?(Array).should be_true
    @returning_param[:bounds].should == [0,0,12,12]

    @returning_param[:points].is_a?(Array).should be_true
    @returning_param[:points].should ==  [[0,0],[10,10],[12,12]]
    @returning_param[:type_points].is_a?(Array).should be_true
    @returning_param[:type_points].should ==  [2,2,2]
  end

  [:emr_fillpath,:emr_strokeandfillpath,:emr_strokepath].each do |m|
    it "#{m} - должен вернуть паремтры bounds" do
      @returning_param = TestEmf.send(m,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\003\000\000\000\000\000\000\000\n\000\n\000\f\000\f\000\002\002\002")
      @returning_param[:bounds].is_a?(Array).should be_true
      @returning_param[:bounds].should == [0,0,12,12]
    end
  end
  it "emr_rectangle" do
    @returning_param = TestEmf.emr_rectangle("\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\003\000\000\000\000\000\000\000\n\000\n\000\f\000\f\000\002\002\002")
    @returning_param[:box].is_a?(Array).should be_true
    @returning_param[:box].should == [0,0,12,12]
  end
  [:emr_polypolygon,:emr_polypolyline].each do |m|
    it "#{m}emr_polypolygon" do
      @returning_param = TestEmf.send(m,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\b\000\000\000\b\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\b\000\000\000")
      @returning_param[:bounds].is_a?(Array).should be_true
      @returning_param[:bounds].should == [0,0,12,12]
      @returning_param[:number_of_polygons].should == 8
      @returning_param[:count].should == 8
      @returning_param[:polygon_point_count].is_a?(Array).should be_true
      @returning_param[:polygon_point_count].size.should == 8
      @returning_param[:polygon_point_count].should ==  [0,0,0,0,0,0,0,0]
      @returning_param[:points].is_a?(Array).should be_true
      @returning_param[:points].size.should ==  8
      @returning_param[:points].should ==  [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,8]]
    end
  end
  [:emr_polypolygon16,:emr_polypolyline16].each do |m|
    it "#{m}" do
      @returning_param = TestEmf.send(m,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\b\000\000\000\b\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\b\000")
      @returning_param[:bounds].is_a?(Array).should be_true
      @returning_param[:bounds].should == [0,0,12,12]
      @returning_param[:number_of_polygons].should == 8
      @returning_param[:count].should == 8
      @returning_param[:polygon_point_count].is_a?(Array).should be_true
      @returning_param[:polygon_point_count].size.should == 8
      @returning_param[:polygon_point_count].should ==  [0,0,0,0,0,0,0,0]
      @returning_param[:points].is_a?(Array).should be_true
      @returning_param[:points].size.should ==  8
      @returning_param[:points].should ==  [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,8]]
    end
  end



  it "emr_pie" do
    @returning_param = TestEmf.send(:emr_pie,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\002\000\000\000\002\000\000\000\v\000\000\000\t\000\000\000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:box].is_a?(Array).should be_true
    @returning_param[:box].should == [0,0,12,12]
    @returning_param[:start].is_a?(Array).should be_true
    @returning_param[:start].should == [2,2]
    @returning_param[:end].is_a?(Array).should be_true
    @returning_param[:end].should == [11,9]

  end

  it "emr_roundrect" do
    @returning_param = TestEmf.send(:emr_roundrect,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000\002\000\000\000\002\000\000\000")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:box].is_a?(Array).should be_true
    @returning_param[:box].should == [0,0,12,12]
    @returning_param[:corner].is_a?(Array).should be_true
    @returning_param[:corner].should == [2,2]
  end

  it "emr_setpixelv" do
    @returning_param = TestEmf.send(:emr_setpixelv,"\f\000\000\000\003\000\000\000\2\2\2")
    @returning_param.is_a?(Hash).should be_true
    @returning_param[:pixel].is_a?(Array).should be_true
    @returning_param[:pixel].should == [12,3]
    @returning_param[:color].is_a?(Array).should be_true
    @returning_param[:color].should == [2,2,2]
  end

  
  it " метод emr_exttextouta" do 
    @returning_param = TestEmf.send(:emr_exttextouta,"\000\000\000\000\000\000\000\000\f\000\000\000\f\000\000\000") 
    @returning_param.is_a?(Hash).should be_true 
    @returning_param[:bounds].is_a?(Array).should be_true
    @returning_param[:bounds].should == [0,0,12,12]
  end
  
  it " метод emr_exttextoutw"
  it "emr_smalltextout"
  it "emr_polytextouta"
  it "emr_polytextoutw"

  it "emr_fillrgn"
  it "emr_framergn"
  it "emr_gradientfill"
  it "emr_paintrgn"


end


