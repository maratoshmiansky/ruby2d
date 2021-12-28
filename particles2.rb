require "ruby2d"

set title: "Particles2"

class Point < Line
  def x_move
    @x_move ||= x_move_reset
  end

  def y_move
    @y_move ||= y_move_reset
  end

  def x_move_reset
    @x_move = [-0.3, 0.3, rand(-3.0..3.0)].sample
  end

  def y_move_reset
    @y_move = [-0.3, 0.3, rand(-3.0..3.0)].sample
  end

  def x_edge_check
    unless self.x1.between?(0, 640) || self.x2.between?(0, 640)
      @x_move = -@x_move
      color_swap
    end
  end

  def y_edge_check
    unless self.y1.between?(0, 480) || self.y2.between?(0, 480)
      @y_move = -@y_move
      color_swap
    end
  end

  def color_swap
    self.color = ["white", "yellow", "orange", "red"].sample
  end
end

num_of_points = 4000
grid_square = Math.sqrt(num_of_points).floor
points = []

grid_square.times do |i|
  grid_square.times do |j|
    x_init, y_init = grid_square * i * Window.width / num_of_points, grid_square * j * Window.height / num_of_points
    x_offset, y_offset = x_init + 1, y_init + 1

    points << Point.new(x1: x_init, y1: y_init, x2: x_offset, y2: y_offset, width: 1, color: "white")
  end
end

update do
  points.each do |point|
    point.x_edge_check
    point.y_edge_check

    point.x1 += point.x_move
    point.x2 += point.x_move
    point.y1 += point.y_move
    point.y2 += point.y_move
  end
end

show
