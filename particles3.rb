require "ruby2d"

set title: "Particles!"

set width: 650, height: 600

NUM_OF_POINTS_X, NUM_OF_POINTS_Y = 20, 20
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_MOVE_BOUND, Y_MOVE_BOUND = 1.0, 1.0
X_SPEED, Y_SPEED = 0.01, 0.01
X_MAX_SPEED, Y_MAX_SPEED = 2.0, 2.0

class Point < Square
  def x_move
    @x_move ||= x_move_reset
  end

  def y_move
    @y_move ||= y_move_reset
  end

  def x_accel
    if @x_move.abs < X_MAX_SPEED
      if @x_move >= 0
        @x_move += X_SPEED
      else
        @x_move -= X_SPEED
      end
    else
      x_move_reset
    end
  end

  def y_accel
    if @y_move.abs < Y_MAX_SPEED
      if @y_move >= 0
        @y_move += Y_SPEED
      else
        @y_move -= Y_SPEED
      end
    else
      y_move_reset
    end
  end

  def x_move_reset
    @x_move = rand(-X_MOVE_BOUND..X_MOVE_BOUND)
  end

  def y_move_reset
    @y_move = rand(-Y_MOVE_BOUND..Y_MOVE_BOUND)
  end

  def x_bounce
    @x_move = -@x_move
  end

  def y_bounce
    @y_move = -@y_move
  end

  def x_hits_left?
    self.x <= X_WINDOW_OFFSET
  end

  def x_hits_right?
    self.x >= Window.width - X_WINDOW_OFFSET
  end

  def y_hits_top?
    self.y <= Y_WINDOW_OFFSET
  end

  def y_hits_bottom?
    self.y >= Window.height - Y_WINDOW_OFFSET
  end

  def color_swap
    self.color = %w(white yellow orange red).sample
  end
end

points = []

# set up point grid
NUM_OF_POINTS_X.times do |i|
  NUM_OF_POINTS_Y.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * VIEWPORT_WIDTH / NUM_OF_POINTS_X
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * VIEWPORT_HEIGHT / NUM_OF_POINTS_Y
    # puts "x: #{x_init}, y: #{y_init}"
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

update do
  points.each do |point|
    point.x += point.x_move
    point.y += point.y_move

    if point.x_hits_left? || point.x_hits_right?
      point.x_bounce
    end

    if point.y_hits_top? || point.y_hits_bottom?
      point.y_bounce
    end

    point.x_accel
    point.y_accel
  end
end

show
