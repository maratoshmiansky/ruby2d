require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 5, 5
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_MOVE_MIN, Y_MOVE_MIN = 1.0, 1.0
X_SPEED_MIN, Y_SPEED_MIN = 1.0, 1.0
X_SPEED_MAX, Y_SPEED_MAX = 12.0, 12.0
# X_SPEED_DELTA, Y_SPEED_DELTA = 0.1, 0.1
Y_GRAVITY = 0.005

class Point < Square
  attr_reader :x_accelerating, :y_accelerating

  def move
    self.x += @x_move_mult * @x_move
    self.y += @y_move_mult * @y_move
  end

  def x_accelerate
    # @x_speed += X_SPEED_DELTA
    @x_move += @x_speed
  end

  def x_decelerate
    # @x_speed -= X_SPEED_DELTA
    @x_move -= @x_speed
  end

  def y_accelerate
    @y_speed += Y_GRAVITY
    @y_move += @y_speed
  end

  def y_decelerate
    @y_speed -= Y_GRAVITY
    @y_move -= @y_speed
  end

  def set_x_accelerating
    if @x_speed <= X_SPEED_MAX
      @x_accelerating = true
    else
      @x_accelerating = false
    end
  end

  def set_y_accelerating
    if @y_speed <= Y_SPEED_MAX
      @y_accelerating = true
    else
      @y_accelerating = false
    end
  end

  def x_edge_check
    if x_hits_left? && !@x_moving_right
      @x_move_mult = 1
      @x_moving_right = true
    elsif x_hits_right? && @x_moving_right
      @x_move_mult = -1
      @x_moving_right = false
    end
  end

  def y_edge_check
    if y_hits_top? && !@y_moving_down
      @y_move_mult = 1
      @y_moving_down = true
    elsif y_hits_bottom? && @y_moving_down
      @y_move_mult = -1
      @y_moving_down = false
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
    @x_init, @y_init = @x, @y
    @x_move_mult, @y_move_mult = 1, 1
    @x_moving_right, @y_moving_down = true, true
    @x_speed = X_SPEED_MIN
    @y_speed = Y_SPEED_MIN
    @x_accelerating, @y_accelerating = true, true
    @x_move = X_MOVE_MIN
    @y_move = Y_MOVE_MIN
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
    point.set_x_accelerating
    point.set_y_accelerating
    # speed up?
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
