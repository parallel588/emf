# -*- encoding: utf-8 -*-

$KCODE='u'
$:.push File.join(File.dirname(__FILE__), 'emf')

require "logger"
require 'rubygems'


module Emf
  autoload :EmfFile,      'emf/emf_file'
  autoload :EmfObj,       'emf/structure/emf_obj'
  autoload :RecordType ,  'emf/structure/enumeration/record_type'
  autoload :EmfDraw ,     'emf/structure/record/emf_draw'
  autoload :EmfPathBracket ,     'emf/structure/record/emf_path_bracket'

  class << self
    @@log = Logger.new(STDOUT)
    def log(message)
      @@log.info(message)
    end
  end
end

Emf.log("Program started")


# ------------------------------------------------------------------------------------------
# log = Logger.new(STDOUT)
#   log.level = Logger::WARN

#   log.debug("Created logger")
#   log.info("Program started")
#   log.warn("Nothing to do!")

#   begin
#     File.each_line(path) do |line|
#       unless line =~ /^(\w+) = (.*)$/
#         log.error("Line in wrong format: #{line}")
#       end
#     end
#   rescue => err
#     log.fatal("Caught exception; exiting")
#     log.fatal(err)
#   end


































