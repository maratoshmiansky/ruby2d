require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

NUM_OF_POINTS = 1000
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_CENTER_OFFSET, Y_CENTER_OFFSET = 0, 0
X_SPEED_MIN, Y_SPEED_MIN = 0.0, 0.0
X_SPEED_MAX, Y_SPEED_MAX = 4.0, 4.0
X_SPEED_DELTA, Y_SPEED_DELTA = 0.2, 0.2

class Point < Square
  attr_reader :x_accelerating, :y_accelerating

  def move
    self.x += @x_mult * @x_speed
    self.y += @y_mult * @y_speed
  end

  def x_accelerate
    @x_speed += rand(0.0..X_SPEED_DELTA)
  end

  def x_decelerate
    @x_speed -= rand(0.0..X_SPEED_DELTA)
  end

  def y_accelerate
    @y_speed += rand(0.0..Y_SPEED_DELTA)
  end

  def y_decelerate
    @y_speed -= rand(0.0..Y_SPEED_DELTA)
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
    @x_mult, @y_mult = [-1, 1].sample, [-1, 1].sample
    @x_speed, @y_speed = X_SPEED_MIN, Y_SPEED_MIN
    @x_accelerating, @y_accelerating = true, true
  end
end

points = []

NUM_OF_POINTS.times do
  x_init = rand(X_CENTER - X_CENTER_OFFSET..X_CENTER + X_CENTER_OFFSET)
  y_init = rand(Y_CENTER - Y_CENTER_OFFSET..Y_CENTER + Y_CENTER_OFFSET)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
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
