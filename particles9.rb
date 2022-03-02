require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_SPEED_MIN, Y_SPEED_MIN = 0.0, 0.0
X_SPEED_MAX, Y_SPEED_MAX = 6.0, 6.0
X_SPEED_DELTA, Y_SPEED_DELTA = 0.5, 0.5

class Point < Square
  attr_reader :x_accelerating, :y_accelerating

  def move
    self.x += @x_mult * @x_speed
    self.y += @y_mult * @y_speed
  end

  def x_accelerate
    if @x_speed < X_SPEED_MAX
      @x_speed += rand(0.0..X_SPEED_DELTA)
    end
  end

  def x_decelerate
    if @x_speed > X_SPEED_MIN
      @x_speed -= rand(0.0..X_SPEED_DELTA)
    end
  end

  def y_accelerate
    if @y_speed < Y_SPEED_MAX
      @y_speed += rand(0.0..Y_SPEED_DELTA)
    end
  end

  def y_decelerate
    if @y_speed > Y_SPEED_MIN
      @y_speed -= rand(0.0..Y_SPEED_DELTA)
    end
  end

  def set_x_accelerating
    if @x_speed <= X_SPEED_MIN
      @x_accelerating = true
    elsif @x_speed >= X_SPEED_MAX
      @x_accelerating = false
    end
  end

  def set_y_accelerating
    if @y_speed <= Y_SPEED_MIN
      @y_accelerating = true
    elsif @y_speed >= Y_SPEED_MAX
      @y_accelerating = false
    end
  end

  def x_edge_check
    if x_hits_left?
      @x_mult = 1
    elsif x_hits_right?
      @x_mult = -1
    end
  end

  def y_edge_check
    if y_hits_top?
      @y_mult = 1
    elsif y_hits_bottom?
      @y_mult = -1
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
    @x_mult, @y_mult = 1, 1
    @x_speed, @y_speed = X_SPEED_MIN, Y_SPEED_MIN
    @x_accelerating, @y_accelerating = true, true
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
    # move point
    point.move
    # bounce?
    point.x_edge_check
    point.y_edge_check
    # speed up?
    point.set_x_accelerating
    point.set_y_accelerating

    if point.x_accelerating
      point.x_accelerate
    else
      point.x_decelerate
    end

    if point.y_accelerating
      point.y_accelerate
    else
      point.y_decelerate
    end
  end
end

show