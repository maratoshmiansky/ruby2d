require "ruby2d"

set title: "Particles!"

NUM_OF_POINTS = 5000

class Point < Square
  attr_reader :x_move, :y_move

  def move
    self.x += @x_move
    self.y += @y_move
  end

  def x_move_reset
    @x_move = rand(-2.0..2.0)
  end

  def y_move_reset
    @y_move = rand(-2.0..2.0)
  end

  def x_bounce
    unless @x.between?(0, 640)
      @x_move = -@x_move
      color_swap
    end
  end

  def y_bounce
    unless @y.between?(0, 480)
      @y_move = -@y_move
      color_swap
    end
  end

  def color_swap
    self.color = ["white", "aqua", "teal", "blue"].sample
  end

  def init
    x_move_reset
    y_move_reset
  end
end

points = []

NUM_OF_POINTS.times do
  x_init, y_init = rand(0..640), rand(0..480)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
end

points.each do |point|
  point.init
end

update do
  points.each do |point|
    # bounce and change color when point hits window edge
    point.x_bounce
    point.y_bounce
    point.move
  end
end

show
