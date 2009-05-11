module Emf

  class EmfFile < File
    include RecordType
    include EmfObj
    include EmfDraw
    include EmfPathBracket
    attr_reader :records
    def initialize(file, *mode)
      binmode
      @records = []
      super
    end

    def try?
      header
      @header[:record_type] == EMR_HEADER  &&
        @header[:signature] == EMR_SIGNATURE
    end

    def header
      seek(0)
      @header = {
        :record_type => ri, :record_size   => ri,
        :bounds_left => ri, :bounds_right  => ri,
        :bounds_top  => ri, :bounds_bottom => ri,
        :frame_left => ri, :frame_right => ri,
        :frame_top => ri, :frame_bottom => ri,
        :signature => ri, :version => ri,
        :size => ri,  :num_of_records => ri,
        :num_of_handles => read_short_int,
        :reserved => read_short_int,
        :size_of_descrip => ri, :off_of_descrip => ri,
        :num_pal_entries => ri,
        :width_dev_pixels => ri, :height_dev_pixels => ri,
        :width_dev_mm => ri, :height_dev_mm => ri}
    end

    def parse
      raise "не верный формат заголовка файла" unless try?
      @rec = []
      seek(@header[:record_size])
      (@header[:num_of_records]-1).times do |r|
        @function,@size = ri,ri
        @params = read(@size-8)
        @r = self.class.send(RECORD_TYPE[@function].to_s.downcase,@params)
        @records << [RECORD_TYPE[@function], @r]  if @r
        @rec << RECORD_TYPE[@function] unless @r
      end
      # return @rec.uniq
      return records
    end
    # private
    class << self
      def method_missing(method, *args)
        # Emf.log "call methods #{method}"
        nil
      end
    end
# --------------------------------------------------------------
    def read_int
      read(4).unpack("V").first
    end
    alias ri read_int

    def read_short_int
      read(2).unpack("v").first
    end

    def read_float
      read(4).unpack("F").first
    end

  end
end
