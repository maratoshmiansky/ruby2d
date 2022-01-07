require "ruby2d"

set title: "Particles!"

set width: 650, height: 600

NUM_OF_POINTS_X, NUM_OF_POINTS_Y = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_DELTA_MIN, ANGLE_DELTA_MAX = 0.1, 4.0
ANGLE_DELTA_DELTA = 0.05
X_ANGLE_MULT_MIN, X_ANGLE_MULT_MAX = 1, 4
Y_ANGLE_MULT_MIN, Y_ANGLE_MULT_MAX = 1, 4
RADIUS_MIN, RADIUS_MAX = 50.0, 100.0

class Point < Square
  attr_accessor :x_init, :y_init, :clockwise, :angle_delta, :accelerating

  def angle
    @angle ||= angle_reset
  end

  def angle_reset
    @angle = rand(0..360)
  end

  def angle_increment
    @angle = (@angle + @angle_delta) % 360
  end

  def angle_decrement
    @angle = (@angle - @angle_delta) % 360
  end

  def accelerate
    if @angle_delta < ANGLE_DELTA_MAX
      @angle_delta += ANGLE_DELTA_DELTA
    else
      @accelerating = false
    end
  end

  def decelerate
    if @angle_delta > ANGLE_DELTA_MIN
      @angle_delta -= ANGLE_DELTA_DELTA
    else
      @accelerating = true
    end
  end

  def x_angle_mult
    @x_angle_mult ||= x_angle_mult_reset
  end

  def x_angle_mult_reset
    @x_angle_mult = rand(X_ANGLE_MULT_MIN..X_ANGLE_MULT_MAX)
  end

  def y_angle_mult
    @y_angle_mult ||= y_angle_mult_reset
  end

  def y_angle_mult_reset
    @y_angle_mult = rand(Y_ANGLE_MULT_MIN..Y_ANGLE_MULT_MAX)
  end

  def radius
    @radius ||= radius_reset
  end

  def radius_reset
    @radius = rand(RADIUS_MIN..RADIUS_MAX)
  end
end

points = []

# set up point grid
NUM_OF_POINTS_X.times do |i|
  NUM_OF_POINTS_Y.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * VIEWPORT_WIDTH / NUM_OF_POINTS_X
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * VIEWPORT_HEIGHT / NUM_OF_POINTS_Y
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

# memorize initial positions of each point and initialize some attributes
points.each do |point|
  point.x_init = point.x
  point.y_init = point.y
  point.clockwise = [true, false].sample
  point.angle_delta = rand(ANGLE_DELTA_MIN..ANGLE_DELTA_MAX)
  point.accelerating = true
end

update do
  points.each do |point|
    point.x = point.x_init + point.radius * Math.cos(point.x_angle_mult * point.angle * DEGS_TO_RADIANS)
    point.y = point.y_init + point.radius * Math.sin(point.y_angle_mult * point.angle * DEGS_TO_RADIANS)

    if point.clockwise
      point.angle_increment
    else
      point.angle_decrement
    end

    if point.accelerating
      point.accelerate
    else
      point.decelerate
    end
  end
end

show
