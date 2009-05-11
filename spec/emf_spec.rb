require 'rubygems'
require File.dirname(__FILE__) + '/../lib/emf'
require 'spec'

describe Emf do
  it "Проверка вывода логов." do
    Emf.log("Programm startet").should be_true
  end
end
