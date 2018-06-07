class Life
  def count_of_alive_cells(cell, row, col)
    (-1..1).map {|i|
      rpos = row + i
      rpos -= @height if rpos >= @height
      (-1..1).map do |j|
        cpos = col + j
        cpos -= @width if cpos >= @width
        @field[rpos][cpos]
      end
    }.flatten.count(true) + (cell ? -1 : 0)
  end

  def next_status(row, col)
    cell = @field[row][col]
    count = count_of_alive_cells(cell, row, col)
    cell ? count.between?(2, 3) : count == 3
  end

  def initialize
    @height, @width = `stty size`.split.map(&:to_i)
    @field = Array.new(@height){Array.new(@width){rand(2) == 1}}
  end
 
  def pass
    @field = Array.new(@height){|row| Array.new(@width){|col| next_status row, col } }
  end

  def dump
    print "\e[1;1H"
    print @field.map{|row| row.map{|cell| cell ? "*":" "}.join}*"\n"
  end

  def clear
    puts "\e[2J"
  end

  def start
    clear
    loop do
      dump
      pass
    end
  end
end

Life.new.start
