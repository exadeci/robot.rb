require_relative "commands_parser"

class Robot
  attr_accessor :placed

  def parse
    @cmd_parser.parse
  end

  def right
    spin(RIGHT)
  end

  def left
    spin(LEFT)
  end

  def move
    x_pos = @x_position
    y_pos = @y_position
    case
      when @facing == "EAST"
        x_pos += 1
        @x_position = x_pos if valid_position?(x_pos)
      when @facing == "WEST"
        x_pos -= 1
        @x_position = x_pos if valid_position?(x_pos)
      when @facing == "NORTH"
        y_pos += 1
        @y_position = y_pos if valid_position?(y_pos)
      when @facing == "SOUTH"
        y_pos -= 1
        @y_position = y_pos if valid_position?(y_pos)
      else
        puts "Invalid direction"
    end
  end

  protected
  attr_accessor :cmd_parser
  private
  attr_accessor :x_position, :y_position, :facing
  POLES = %("WEST", "NORTH", "EAST", "SOUTH").freeze
  LEFT = -1
  RIGHT = 1

  def initialize
    self.x_position = 0
    self.y_position = 0
    self.facing = "SOUTH"
    self.placed = false
    self.cmd_parser = CommandsParser.new(self)
  end

  def place(xyf)
    x, y, f = xyf.split(",")
    @x_position = x.to_i
    @y_position = y.to_i
    @facing = f
    if valid_position?(x.to_i) && valid_position?(y.to_i) && POLES.include?(f)
      @placed = true
    end
  end

  def valid_position?(pos)
    return true if pos <= 5 && pos >= 0
    raise "Invalid movement."
  end

  def spin(direction)
    index = POLES.find_index(@facing)
    new_value = index + direction
    if new_value == -1
      @facing = POLES[3]
    elsif new_value == 4
      @facing = POLES[0]
    else
      @facing = POLES[new_value]
    end
  end

  def report
    puts "#{@x_position},#{@y_position},#{@facing}"
  end
end

if __FILE__ == $0
  Robot.new.parse
end
