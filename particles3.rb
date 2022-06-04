require "ruby2d"

set width: 600, height: 600, title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_DELTA_MIN, ANGLE_DELTA_MAX, ANGLE_DELTA_DELTA = 0.1, 2.0, 0.05
X_ANGLE_MULT_MIN, X_ANGLE_MULT_MAX = 1.0, 4.0
Y_ANGLE_MULT_MIN, Y_ANGLE_MULT_MAX = 1.0, 4.0
RADIUS_MIN, RADIUS_MAX = 50.0, 100.0

class Point < Square
  def move
    self.x = @x_init + @radius * Math.cos(@x_angle_mult * @angle * DEGS_TO_RADIANS)
    self.y = @y_init + @radius * Math.sin(@y_angle_mult * @angle * DEGS_TO_RADIANS)
  end

  def angle_increment_decrement
    if clockwise?
      @angle = (@angle + @angle_delta) % 360
    else
      @angle = (@angle - @angle_delta) % 360
    end
  end

  def clockwise?
    @clockwise
  end

  def accelerate_decelerate
    accelerating? ? accelerate : decelerate
  end
  
  def accelerating?
    @accelerating
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
    @x_init, @y_init = @x, @y
    @clockwise = [true, false].sample
    @angle_delta = rand(ANGLE_DELTA_MIN..ANGLE_DELTA_MAX)
    @accelerating = true
    @radius = rand(RADIUS_MIN..RADIUS_MAX)
    @angle = rand(0..359)
    @x_angle_mult = rand(X_ANGLE_MULT_MIN..X_ANGLE_MULT_MAX)
    @y_angle_mult = rand(Y_ANGLE_MULT_MIN..Y_ANGLE_MULT_MAX)
  end
end

points = []

X_NUM_OF_POINTS.times do |i|
  Y_NUM_OF_POINTS.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

points.each { |point| point.init }

update do
  points.each do |point|
    point.move
    point.angle_increment_decrement
    point.accelerate_decelerate
  end
end

show
