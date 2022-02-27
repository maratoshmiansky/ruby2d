require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_MOVE_BOUND, Y_MOVE_BOUND = 1.0, 1.0
X_SPEED, Y_SPEED = 0.5, 0.5
X_SPEED_MAX, Y_SPEED_MAX = 4.0, 4.0

class Point < Square
  def move
    self.x += @x_move
    self.y += @y_move
  end

  def x_accel
    if @x_move.abs < X_SPEED_MAX
      @x_move += rand(-X_SPEED..X_SPEED)
    else
      x_move_reset
    end
  end

  def y_accel
    if @y_move.abs < Y_SPEED_MAX
      @y_move += rand(-Y_SPEED..Y_SPEED)
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
    unless @x.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET)
      @x_move = -@x_move
    end
  end

  def y_edge_check
    unless @y.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET)
      @y_move = -@y_move
    end
  end

  def init
    x_move_reset
    y_move_reset
  end
end

points = []

# set up point grid
X_NUM_OF_POINTS.times do |i|
  Y_NUM_OF_POINTS.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

points.each do |point|
  point.init
end

update do
  points.each do |point|
    point.move
    # bounce?
    point.x_edge_check
    point.y_edge_check
    # speed up?
    point.x_accel
    point.y_accel
  end
end

show
