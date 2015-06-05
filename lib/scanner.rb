class Scanner
  attr_reader :groups

  def initialize(file, size)
    @file = file
    @size = size

    @clues = {}
    @colors = {}
    parse_clues
    parse_colors

    @adjacencies = {}
    build_adjacencies

    @groups = []
    build_groups
  end

  def parse_clues
    tess = Tesseract::Engine.new {|t|
      t.language = :eng
    }

    # Currently hard-coded positions for 4x4 board
    [50, 225, 400, 575].each_with_index do |row, y|
      [405, 580, 755, 930].each_with_index do |col, x|
        text = tess.text_for('crop.png', col, row, 50, 100).strip.gsub(":", "=").gsub(/^[^0-9].*/, '')
        next if text.empty?
        @clues[key(y,x)] = text
      end
    end
  end

  def parse_colors
    image = Magick::ImageList.new("crop.png")
    image3 = image.quantize(32, Magick::RGBColorspace, Magick::NoDitherMethod)

    # Currently hard-coded positions for 4x4 board
    [50, 225, 400, 575].each_with_index do |row, y|
      [405, 580, 755, 930].each_with_index do |col, x|
        pixel = image3.pixel_color(col+5, row+5)
        hexcolor = [pixel.red, pixel.green, pixel.blue].map{|v| "%02x" % (v/257) }.join
        @colors[key(y,x)] = ord_color(hexcolor)
      end
    end
  end

  def build_adjacencies
    (0...@size).each do |y|
      (0...@size).each do |x|
        @adjacencies[key(y,x)] = [
          [y-1, x  ], # above
          [y  , x+1], # right
          [y+1, x  ], # below
          [y  , x-1], # left
        ].reject { |y,x|
          y < 0 or x < 0 or y >= @size or x >= @size
        }.sort.map{| y,x|
          key(y,x)
        }
      end
    end
  end

  def build_groups
    @clues.keys.each do |root|
      group = {}
      group[:total] = @clues[root][/^\d+/].to_i
      group[:op]    = op(@clues[root][/[^0-9]?$/])
      group[:cells] = [root]

      candidates = @adjacencies[root]
      while !candidates.empty?
        candidate = candidates.pop
        next if group[:cells].include? candidate

        if @colors[candidate] == @colors[root]
          group[:cells] << candidate
          candidates += @adjacencies[candidate]
          candidates.uniq!
        end
      end
      group[:cells].sort!
      @groups << group
    end
  end

private
  def key(y,x)
    [('A'.ord+y).chr, x+1].join.to_sym
  end

  def ord_color(color)
    @color_ordinals ||= {}
    @color_ordinal_next ||= '`' # char before 'a'
    @color_ordinals[color] ||= @color_ordinal_next.succ!.dup
  end

  def op(op)
    { "=" => :equals,
      "+" => :sum,
      "-" => :difference,
      "*" => :product,
      "/" => :quotient,
      # sequence
      # inequality
    }[op]
  end
end
