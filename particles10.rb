require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

NUM_OF_POINTS = 1000
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_CENTER_OFFSET, Y_CENTER_OFFSET = 20.0, 20.0
X_SPEED_MIN, Y_SPEED_MIN = 0.0, 0.0
X_SPEED_MAX, Y_SPEED_MAX = 4.0, 12.0
X_SPEED_DELTA, Y_SPEED_DELTA = 0.1, 0.2

class Point < Square
  def move
    self.x += @x_speed
    self.y += @y_speed
  end

  def x_accel
    if @x_speed < X_SPEED_MAX
      @x_speed += [-X_SPEED_DELTA, X_SPEED_DELTA].sample
    else
      @x_speed = rand(-X_SPEED_MAX..X_SPEED_MAX)
    end
  end

  def y_accel
    if @y_speed < Y_SPEED_MAX
      if @y_accelerating
        @y_speed += Y_SPEED_DELTA
      else
        @y_speed -= Y_SPEED_DELTA
      end
    else
      @y_speed = rand(Y_SPEED_MIN..Y_SPEED_MAX)
    end
  end

  def set_y_accelerating
    if @y_speed < Y_SPEED_MIN
      @y_accelerating = true
    elsif @y_speed > Y_SPEED_MAX
      @y_accelerating = false
    end
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
    @x_speed, @y_speed = rand(-X_SPEED_MAX..X_SPEED_MAX), rand(Y_SPEED_MIN..Y_SPEED_MAX)
    @y_accelerating = true
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
    # bounce?
    point.x_edge_check
    point.y_edge_check
    # move point
    point.move
    # speed up?
    point.set_y_accelerating
    point.x_accel
    point.y_accel
  end
end

show
