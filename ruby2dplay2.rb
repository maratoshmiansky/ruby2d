require "ruby2d"

set width: 650, height: 600, title: "Particles!"

NUM_OF_POINTS = 400
ANGLE_DELTA = 1
ANGLE_DELTA_DELTA = 0.01
X_MULT_MIN, X_MULT_MAX = 10.0, 100.0
Y_MULT_MIN, Y_MULT_MAX = 10.0, 100.0
X_ANGLE_MULT_MIN, X_ANGLE_MULT_MAX = 2.0, 6.0
Y_ANGLE_MULT_MIN, Y_ANGLE_MULT_MAX = 2.0, 6.0
DEGS_TO_RADIANS = Math::PI / 180
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60

class Point < Square
  attr_accessor :x_init, :y_init, :x_mult, :y_mult, :angle, :angle_delta, :x_angle_mult, :y_angle_mult, :accelerating

  def angle_delta_check
    if @angle <= 0
      @angle_delta = ANGLE_DELTA
    elsif @angle >= 360
      @angle_delta = -ANGLE_DELTA
    end
  end

  def accelerate
    if @angle.between?(0, 179)
      @angle_delta += ANGLE_DELTA_DELTA
    else
      @accelerating = false
    end
  end

  def decelerate
    if @angle.between?(180, 359)
      @angle_delta -= ANGLE_DELTA_DELTA
    else
      @accelerating = true
    end
  end
end

points = []

NUM_OF_POINTS.times do
  x_init = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
  y_init = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
end

points.each do |point|
  point.x_init = point.x
  point.y_init = point.y
  point.angle = rand(0..359)
  point.angle.between?(0, 179) ? point.accelerating = true : point.accelerating = false
  point.x_mult = [-1, 1].sample * rand(X_MULT_MIN..X_MULT_MAX)
  point.y_mult = [-1, 1].sample * rand(Y_MULT_MIN..Y_MULT_MAX)
  point.x_angle_mult = rand(X_ANGLE_MULT_MIN..X_ANGLE_MULT_MAX)
  point.y_angle_mult = rand(Y_ANGLE_MULT_MIN..Y_ANGLE_MULT_MAX)
  point.angle_delta = ANGLE_DELTA + point.angle * ANGLE_DELTA_DELTA / [point.x_angle_mult.abs, point.y_angle_mult.abs].max
end

update do
  points.each do |point|
    point.angle_delta_check
    point.accelerating ? point.accelerate : point.decelerate
    point.angle += point.angle_delta
    point.x = point.x_init + point.x_mult * Math.cos(point.x_angle_mult * point.angle * DEGS_TO_RADIANS)
    point.y = point.y_init + point.y_mult * Math.sin(point.y_angle_mult * point.angle * DEGS_TO_RADIANS)
  end
end

show
