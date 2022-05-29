require "ruby2d"

set width: 600, height: 600, title: "Particles!"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
DEGS_TO_RADIANS = Math::PI / 180
NUM_OF_POINTS = 100
ANGLE_DELTA, ANGLE_DELTA_DELTA = 1.0, 0.05
X_MULT_MIN, X_MULT_MAX = 20.0, 50.0
Y_MULT_MIN, Y_MULT_MAX = 20.0, 50.0
X_ANGLE_MULT_MIN, X_ANGLE_MULT_MAX = 1.0, 3.0
Y_ANGLE_MULT_MIN, Y_ANGLE_MULT_MAX = 1.0, 3.0

class Point < Square
  def animate
    angle_delta_check
    accelerating? ? accelerate : decelerate
    @angle += @angle_delta
    self.x = @x_init + @x_mult * Math.cos(@x_angle_mult * @angle * DEGS_TO_RADIANS)
    self.y = @y_init + @y_mult * Math.sin(@y_angle_mult * @angle * DEGS_TO_RADIANS)
  end

  def angle_delta_check
    if @angle < 0
      @angle_delta = ANGLE_DELTA
    elsif @angle >= 360
      @angle_delta = -ANGLE_DELTA
    end
  end

  def accelerating?
    @accelerating
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

  def init
    @x_init, @y_init = @x, @y
    @angle = rand(0..359)
    @angle.between?(0, 179) ? @accelerating = true : @accelerating = false
    @x_mult = [-1, 1].sample * rand(X_MULT_MIN..X_MULT_MAX)
    @y_mult = [-1, 1].sample * rand(Y_MULT_MIN..Y_MULT_MAX)
    @x_angle_mult = rand(X_ANGLE_MULT_MIN..X_ANGLE_MULT_MAX)
    @y_angle_mult = rand(Y_ANGLE_MULT_MIN..Y_ANGLE_MULT_MAX)
    @angle_delta = @angle * ANGLE_DELTA_DELTA
  end
end

points = []

NUM_OF_POINTS.times do
  x_init = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
  y_init = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
end

points.each { |point| point.init }

update do
  points.each { |point| point.animate }
end

show
