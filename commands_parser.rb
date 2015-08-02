class CommandsParser

  attr_accessor :robot

  def parse
    ARGF.readlines.each do |line|
      line_array = line.split(" ")
      method = line_array.first.downcase
      args = line_array[1]
      @robot.send(method, *args) if placed?(method)
    end
  rescue => e
    puts "There was an error: #{e.message}"
  ensure
    ARGF.close
  end

  def placed?(method)
    return true if method == "place" || @robot.placed
    raise "Robot not placed, please place it first."
  end

  def initialize(robot)
    self.robot = robot
  end

end
