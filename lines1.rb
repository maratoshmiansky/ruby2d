require "ruby2d"

set title: "Lines1"

set width: 640, height: 600

# CONSTANTS
NUM_OF_LINES = 20
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 100, 100
X_LINE_LENGTH_BOUND, Y_LINE_LENGTH_BOUND = 40.0, 40.0
MAX_LINES = 20 * NUM_OF_LINES
X_MOVE_BOUND, Y_MOVE_BOUND = 1, 1
X_SPEED, Y_SPEED = 0.2, 0.2
X_MAX_SPEED, Y_MAX_SPEED = 4.0, 4.0

class Line
  def x_move
    @x_move ||= x_move_reset
  end

  def y_move
    @y_move ||= y_move_reset
  end

  def x_accel
    if @x_move.abs < X_MAX_SPEED
      if @x_move >= 0
        @x_move += rand(-X_SPEED..X_SPEED)
      else
        @x_move -= rand(-X_SPEED..X_SPEED)
      end
    else
      x_move_reset
    end
  end

  def y_accel
    if @y_move.abs < Y_MAX_SPEED
      if @y_move >= 0
        @y_move += rand(-Y_SPEED..Y_SPEED)
      else
        @y_move -= rand(-Y_SPEED..Y_SPEED)
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

  def x_edge_check
    unless self.x1.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET) || self.x2.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET)
      @x_move = -@x_move
      # color_swap
    end
  end

  def y_edge_check
    unless self.y1.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET) || self.y2.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET)
      @y_move = -@y_move
      # color_swap
    end
  end

  # def color_swap
  #   self.color = ["white", "fuchsia", "yellow"].sample
  # end
end

grid_square = Math.sqrt(NUM_OF_LINES).floor
x_viewport_adj = (Window.width - X_WINDOW_OFFSET * 2)
y_viewport_adj = (Window.height - Y_WINDOW_OFFSET * 2)
lines = []

# set up line grid
grid_square.times do |i|
  grid_square.times do |j|
    x1_init = X_WINDOW_OFFSET + grid_square * (i + 1) * x_viewport_adj / NUM_OF_LINES
    y1_init = Y_WINDOW_OFFSET + grid_square * (j + 1) * y_viewport_adj / NUM_OF_LINES
    x2_init = x1_init + rand(-X_LINE_LENGTH_BOUND..X_LINE_LENGTH_BOUND)
    y2_init = y1_init + rand(-Y_LINE_LENGTH_BOUND..Y_LINE_LENGTH_BOUND)

    lines << Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")
  end
end

(MAX_LINES / NUM_OF_LINES).times do
  lines.each do |line|
    x1_new = line.x2
    y1_new = line.y2
    x2_new = x1_new + rand(-X_LINE_LENGTH_BOUND..X_LINE_LENGTH_BOUND)
    y2_new = y1_new + rand(-Y_LINE_LENGTH_BOUND..Y_LINE_LENGTH_BOUND)
    Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: "white")
  end
end

# update do
#   lines.each do |line|
#     # move
#     line.x1 += line.x_move
#     line.x2 += line.x_move
#     line.y1 += line.y_move
#     line.y2 += line.y_move
#     # bounce?
#     line.x_edge_check
#     line.y_edge_check
#     # speed up?
#     line.x_accel
#     line.y_accel
#   end
# end

show
