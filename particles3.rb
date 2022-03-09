require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_DELTA_MIN, ANGLE_DELTA_MAX = 0.1, 4.0
ANGLE_DELTA_DELTA = 0.05
X_ANGLE_MULT_MIN, X_ANGLE_MULT_MAX = 1, 4
Y_ANGLE_MULT_MIN, Y_ANGLE_MULT_MAX = 1, 4
RADIUS_MIN, RADIUS_MAX = 50.0, 100.0

class Point < Square
  attr_reader :clockwise, :accelerating

  def move
    self.x = @x_init + @radius * Math.cos(@x_angle_mult * @angle * DEGS_TO_RADIANS)
    self.y = @y_init + @radius * Math.sin(@y_angle_mult * @angle * DEGS_TO_RADIANS)
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

  def init
    @x_init = @x
    @y_init = @y
    @clockwise = [true, false].sample
    @angle_delta = rand(ANGLE_DELTA_MIN..ANGLE_DELTA_MAX)
    @accelerating = true
    @radius = rand(RADIUS_MIN..RADIUS_MAX)
    @angle = rand(0..360)
    @x_angle_mult = rand(X_ANGLE_MULT_MIN..X_ANGLE_MULT_MAX)
    @y_angle_mult = rand(Y_ANGLE_MULT_MIN..Y_ANGLE_MULT_MAX)
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
