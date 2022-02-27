require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 5, 5
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_MOVE_BOUND, Y_MOVE_BOUND = 1.0, 1.0
X_SPEED, Y_SPEED = 0.5, 0.5
X_SPEED_MAX, Y_SPEED_MAX = 12.0, 12.0

class Point < Square
  attr_accessor :x_move, :y_move, :x_bounced, :y_bounced

  def move
    self.x += @x_move
    self.y += @y_move
  end

  def x_accel
    if @x_move.abs < X_SPEED_MAX
      @x_move += rand(0.0..X_SPEED)
    else
      x_reinitialize
      x_move_reset
    end
  end

  def y_accel
    if @y_move.abs < Y_SPEED_MAX
      @y_move += rand(0.0..Y_SPEED)
    else
      y_reinitialize
      y_move_reset
    end
  end

  def x_reinitialize
    @x = @x_init
  end

  def y_reinitialize
    @y = @y_init
  end

  def x_move_reset
    @x_move = rand(-X_MOVE_BOUND..X_MOVE_BOUND)
  end

  def y_move_reset
    @y_move = rand(-Y_MOVE_BOUND..Y_MOVE_BOUND)
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
    @x_bounced, @y_bounced = false, false
    x_move_reset
    y_move_reset
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
    if !point.x_bounced && (point.x_hits_left? || point.x_hits_right?)
      point.x_move = -point.x_move
      point.x_bounced = true
    else
      point.x_bounced = false
    end

    if !point.y_bounced && (point.y_hits_top? || point.y_hits_bottom?)
      point.y_move = -point.y_move
      point.y_bounced = true
    else
      point.y_bounced = false
    end

    # speed up?
    point.x_accel
    point.y_accel
  end
end

show
