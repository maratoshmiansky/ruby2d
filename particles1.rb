require "ruby2d"

set title: "Particles1"

class Point < Line
  attr_accessor :x_mult, :y_mult

  def x_mult
    @x_mult = @x_mult || rand(-5.0..5.0)
  end

  def y_mult
    @y_mult = @y_mult || rand(-5.0..5.0)
  end
end

num_of_points = 1000
points = []

num_of_points.times do
  x_init, y_init = rand(0..640), rand(0..480)
  x_offset, y_offset = x_init + rand(-1..1), y_init + rand(-1..1)

  points << Point.new(x1: x_init, y1: y_init, x2: x_offset, y2: y_offset, width: 1, color: "white")
end

update do
  points.each do |point|
    x_move = point.x_mult
    y_move = point.y_mult

    if point.x1 < 0 || point.x2 < 0
      point.x1 += 640
      point.x2 += 640
    elsif point.x1 > 640 || point.x2 > 640
      point.x1 -= 640
      point.x2 -= 640
    end

    if point.y1 < 0 || point.y2 < 0
      point.y1 += 480
      point.y2 += 480
    elsif point.y1 > 480 || point.y2 > 480
      point.y1 -= 480
      point.y2 -= 480
    end

    point.x1 += x_move
    point.x2 += x_move
    point.y1 += y_move
    point.y2 += y_move
  end
end

show
