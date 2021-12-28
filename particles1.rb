require "ruby2d"

set title: "Particles1"

class Point < Line
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
    unless self.x1.between?(0, 640) || self.x2.between?(0, 640)
      @x_move = -@x_move
      color_swap
    end
  end

  def y_bounce
    unless self.y1.between?(0, 480) || self.y2.between?(0, 480)
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
  x_offset, y_offset = x_init + rand(-1..1), y_init + rand(-1..1)

  points << Point.new(x1: x_init, y1: y_init, x2: x_offset, y2: y_offset, width: 1, color: "white")
end

update do
  points.each do |point|
    # bounce and change color when point hits window edge
    point.x_bounce
    point.y_bounce

    point.x1 += point.x_move
    point.x2 += point.x_move
    point.y1 += point.y_move
    point.y2 += point.y_move
  end
end

show
