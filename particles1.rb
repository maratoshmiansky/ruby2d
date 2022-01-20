require "ruby2d"

set title: "Particles!"

class Point < Square
  def x_move
    @x_move ||= x_move_reset
  end

  def y_move
    @y_move ||= y_move_reset
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
end

num_of_points = 5000
points = []

num_of_points.times do
  x_init, y_init = rand(0..640), rand(0..480)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
end

update do
  points.each do |point|
    # bounce and change color when point hits window edge
    point.x_bounce
    point.y_bounce
    point.x += point.x_move
    point.y += point.y_move
  end
end

show
