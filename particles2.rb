require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_SPEED, Y_SPEED = 0.1, 0.5
X_SPEED_MAX, Y_SPEED_MAX = 12.0, 12.0

class Point < Square
  def move
    self.x += @x_speed
    self.y += @y_speed
  end

  def x_accel
    if @x_speed <= X_SPEED_MAX
      @x_speed += rand(-X_SPEED..X_SPEED)
    else
      x_speed_reset
    end
  end

  def y_accel
    if @y_speed <= Y_SPEED_MAX
      @y_speed += rand(0.0..Y_SPEED)
    else
      y_speed_reset
    end
  end

  def x_speed_reset
    @x_speed = 0.0
  end

  def y_speed_reset
    @y_speed = 0.0
  end

  def x_edge_check
    if x_hits_left? || x_hits_right?
      @x_speed = -@x_speed
    end
  end

  def y_edge_check
    if y_hits_top? || y_hits_bottom?
      @y_speed = -@y_speed
    end
  end

  def x_hits_left?
    @x <= X_WINDOW_OFFSET
  end

  def x_hits_right?
    @x >= Window.width - X_WINDOW_OFFSET
  end

  def y_hits_top?
    @y <= Y_WINDOW_OFFSET
  end

  def y_hits_bottom?
    @y >= Window.height - Y_WINDOW_OFFSET
  end

  def init
    x_speed_reset
    y_speed_reset
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
    # bounce?
    point.x_edge_check
    point.y_edge_check
    # move
    point.move
    # speed up?
    point.x_accel
    point.y_accel
  end
end

show
