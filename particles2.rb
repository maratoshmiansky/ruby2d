require "ruby2d"

set title: "Particles2"

# CONSTANTS
X_MAX_SPEED = 6.0
Y_MAX_SPEED = 6.0
X_MOVE_BOUND, Y_MOVE_BOUND = 2.0, 2.0
X_MOVE_INCR, Y_MOVE_INCR = 0.1, 0.1
X_MOVE_INCR_BOUND, Y_MOVE_INCR_BOUND = 3.0, 3.0
X_WINDOW_OFFSET = 100
Y_WINDOW_OFFSET = 100

class Point < Line
  def x_move
    @x_move ||= x_move_reset
  end

  def y_move
    @y_move ||= y_move_reset
  end

  def x_accel
    if @x_move.abs < X_MAX_SPEED
      if @x_move >= 0
        @x_move += X_MOVE_INCR * rand(-X_MOVE_INCR_BOUND..X_MOVE_INCR_BOUND)
      else
        @x_move -= X_MOVE_INCR * rand(-X_MOVE_INCR_BOUND..X_MOVE_INCR_BOUND)
      end
    else
      x_move_reset
    end
  end
  
  def y_accel
    if @y_move.abs < Y_MAX_SPEED
      if @y_move >= 0
        @y_move += Y_MOVE_INCR * rand(-Y_MOVE_INCR_BOUND..Y_MOVE_INCR_BOUND)
      else
        @y_move -= Y_MOVE_INCR * rand(-Y_MOVE_INCR_BOUND..Y_MOVE_INCR_BOUND)
      end
    else
      y_move_reset
    end
  end

  def x_move_reset
    @x_move = rand(-X_MOVE_BOUND..X_MOVE_BOUND)
  end

  def y_move_reset
    @y_move = rand(-Y_MOVE_BOUND..Y_MOVE_BOUND)
  end

  def x_edge_check
    unless self.x1.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET) || self.x2.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET)
      @x_move = -@x_move
      # color_swap
    end
  end

  def y_edge_check
    unless self.y1.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET) || self.y2.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET)
      @y_move = -@y_move
      # color_swap
    end
  end

  def color_swap
    self.color = ["white", "fuchsia", "yellow"].sample
  end
end

num_of_points = 600
grid_square = Math.sqrt(num_of_points).floor
points = []

grid_square.times do |i|
  grid_square.times do |j|
    x_init = grid_square * (i + 1) * (Window.width - X_WINDOW_OFFSET * 2) / num_of_points + X_WINDOW_OFFSET
    y_init = grid_square * (j + 1) * (Window.height - Y_WINDOW_OFFSET * 2) / num_of_points + Y_WINDOW_OFFSET
    x_offset, y_offset = x_init + 1, y_init + 1

    points << Point.new(x1: x_init, y1: y_init, x2: x_offset, y2: y_offset, width: 1, color: "white")
  end
end

update do
  points.each do |point|
    point.x1 += point.x_move
    point.x2 += point.x_move
    point.y1 += point.y_move
    point.y2 += point.y_move
    
    point.x_edge_check
    point.y_edge_check
    point.x_accel
    point.y_accel
  end
end

show
