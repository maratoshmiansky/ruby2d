require "ruby2d"

set title: "Particles1"

class Point < Line
  def x_mult
    @x_mult ||= x_mult_reset
  end

  def y_mult
    @y_mult ||= y_mult_reset
  end

  def x_mult_reset
    @x_mult = rand(-1.5..1.5)
  end

  def y_mult_reset
    @y_mult = rand(-1.5..1.5)
  end

  def x_mult_reverse_check
    unless self.x1.between?(0, 640) || self.x2.between?(0, 640)
      @x_mult = -@x_mult
      color_swap
    end
  end

  def y_mult_reverse_check
    unless self.y1.between?(0, 480) || self.y2.between?(0, 480)
      @y_mult = -@y_mult
      color_swap
    end
  end

  def color_swap
    self.color = ["white", "purple", "blue", "yellow"].sample
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
    point.x_mult_reverse_check
    point.y_mult_reverse_check
    x_move = point.x_mult
    y_move = point.y_mult

    point.x1 += x_move
    point.x2 += x_move
    point.y1 += y_move
    point.y2 += y_move
  end
end

show
