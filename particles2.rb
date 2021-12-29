require "ruby2d"

set title: "Particles2"

set width: 600, height: 600

# CONSTANTS
NUM_OF_POINTS = 1000
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 100, 100
X_MOVE_BOUND, Y_MOVE_BOUND = 1, 1
X_SPEED, Y_SPEED = 0.2, 0.2
X_MAX_SPEED, Y_MAX_SPEED = 4.0, 4.0

class Point < Square
  def x_move
    @x_move ||= x_move_reset
  end

  def y_move
    @y_move ||= y_move_reset
  end

  def x_accel
    if @x_move.abs < X_MAX_SPEED
      if @x_move >= 0
        @x_move += rand(-X_SPEED..X_SPEED)
      else
        @x_move -= rand(-X_SPEED..X_SPEED)
      end
    else
      x_move_reset
    end
  end
  
  def y_accel
    if @y_move.abs < Y_MAX_SPEED
      if @y_move >= 0
        @y_move += rand(-Y_SPEED..Y_SPEED)
      else
        @y_move -= rand(-Y_SPEED..Y_SPEED)
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
    unless self.x.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET)
      @x_move = -@x_move
      # color_swap
    end
  end

  def y_edge_check
    unless self.y.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET)
      @y_move = -@y_move
      # color_swap
    end
  end

  # def color_swap
  #   self.color = ["white", "fuchsia", "yellow"].sample
  # end
end

grid_square = Math.sqrt(NUM_OF_POINTS).floor
x_viewport_adj = (Window.width - X_WINDOW_OFFSET * 2)
y_viewport_adj = (Window.height - Y_WINDOW_OFFSET * 2)
points = []

# set up point grid
grid_square.times do |i|
  grid_square.times do |j|
    x_init = X_WINDOW_OFFSET + grid_square * (i + 1) * x_viewport_adj / NUM_OF_POINTS
    y_init = Y_WINDOW_OFFSET + grid_square * (j + 1) * y_viewport_adj / NUM_OF_POINTS

    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

update do
  points.each do |point|
    # move
    point.x += point.x_move
    point.y += point.y_move
    # bounce?
    point.x_edge_check
    point.y_edge_check
    # speed up?
    point.x_accel
    point.y_accel
  end
end

show
