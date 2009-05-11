require File.dirname(__FILE__) + '/spec_helper'

describe EmfFile do
  describe "При открытие Emf файла:" do
    it "При верных аргуметах должен вернуть объект EmfFile" do
      EmfFile.new("data/sheme_102.emf").should be_true
    end

    it "При неверных аргуметах должен вызвать панику (не указан фалй)" do
      EmfFile.should_receive(:new).and_raise(ArgumentError.new(EmfFile.new))
    end

    it "При неверных аргуметах должен вызвать панику (не найден файл)" do
      # EmfFile.should_receive(:new).with("data/sheme.emf").and_raise(Errno::ENOENT)
    end
  end

  describe "Инициоизация EmfFile объекта" do
    it "список записей должен быть пустым" do
      EmfFile.new("data/sheme_102.emf").records.should be_empty
    end
  end

  describe "Проверка файла:" do
    before :each do

    end
    it "Если файл являеться файлом Emf: положительный результат" do
      EmfFile.new("data/sheme_102.emf").try?.should be_true
    end
    it "Если файл не являеться файлом Emf: отрицательный результат" do
      EmfFile.new("data/not_valid_sheme_102.emf").try?.should be_false
    end

  end
  describe "Заголовок файла:" do
    it "при положительном результате должен вернуть данные из заголовка файла" do
      EmfFile.new("data/sheme_102.emf").header.should be_true
    end
    it "данные заголовка должны содержать кол-во emf-записей в файле" do
      @header = EmfFile.new("data/sheme_102.emf").header
      @header[:num_of_records].should > 2
    end
  end

  describe "Рапознание записей Emf файла" do
    it "при положительном результате должен вернуть список записей с параметрами" do
      @emf_file = EmfFile.new("data/sheme_102.emf")
      @records = @emf_file.parse
      @records.should_not be_empty
    end
  end

  describe "методы чтения" do
    before :each do
      @emf_file = EmfFile.new("data/sheme_102.emf")
    end
    it "должен уметь читать длинное целое число (long integer)" do
      @emf_file.stub!(:read).with(4).and_return("\003\000\000\000")
      @emf_file.read_int.should == 3
    end
    it "должен уметь читать короткое целое число (short integer)" do
      @emf_file.stub!(:read).with(2).and_return("\004\000")
      @emf_file.read_short_int.should == 4
    end
    it "должен уметь читать число в плавающей точкой (float)" do
      @emf_file.stub!(:read).with(4).and_return("\000\000\240@")
      @emf_file.read_float.should == 5
    end
  end
end
