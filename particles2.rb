require "ruby2d"

set title: "Particles!"

set width: 600, height: 600

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 3, 3
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
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
      # x_reinitialize
      x_move_reset
    end
  end

  def y_accel
    if @y_move.abs < Y_SPEED_MAX
      @y_move += rand(0.0..Y_SPEED)
    else
      # y_reinitialize
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
    @x_move = 0.0
  end

  def y_move_reset
    @y_move = 0.0
  end

  def x_edge_check
    if !@x_bounced && (x_hits_left? || x_hits_right?)
      @x_move = -@x_move
      @x_bounced = true
    elsif !(x_hits_left? || x_hits_right?)
      @x_bounced = false
    end
  end

  def y_edge_check
    if !@y_bounced && (y_hits_top? || y_hits_bottom?)
      @y_move = -@y_move
      @y_bounced = true
    elsif !(y_hits_top? || y_hits_bottom?)
      @y_bounced = false
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
    # bounce?
    point.x_edge_check
    point.y_edge_check
    # move
    point.move
    # speed up?
    point.x_accel
    point.y_accel
  end
end

show
