require "ruby2d"

set width: 640, height: 600, title: "Lines1"

# CONSTANTS
NUM_OF_LINES = 25
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 100, 100
X_LINE_LENGTH_BOUND, Y_LINE_LENGTH_BOUND = 40.0, 40.0
MAX_LINES = 20 * NUM_OF_LINES

class Line
  def x_moved_last
    x_moved_reset unless @x_moved_last
  end

  def y_moved_last
    y_moved_reset unless @y_moved_last
  end

  def x_moved_reset
    @x_moved_last = true
    @y_moved_last = false
  end

  def y_moved_reset
    @x_moved_last = false
    @y_moved_last = true
  end
end

grid_square = Math.sqrt(NUM_OF_LINES).floor
x_viewport_adj = (Window.width - X_WINDOW_OFFSET)
y_viewport_adj = (Window.height - Y_WINDOW_OFFSET)
lines, new_lines = [], []

# set up point grid
grid_square.times do |i|
  grid_square.times do |j|
    x1_init = X_WINDOW_OFFSET + grid_square * i * x_viewport_adj / NUM_OF_LINES
    y1_init = Y_WINDOW_OFFSET + grid_square * j * y_viewport_adj / NUM_OF_LINES
    x2_init = x1_init + 1
    y2_init = y1_init + 1

    lines << Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")
  end
end

lines.each do |line|
  [line.x_moved_reset, line.y_moved_reset].sample
end

all_lines = lines

(MAX_LINES / NUM_OF_LINES).times do
  lines.each do |line|
    if line.y_moved_last
      x1_new = line.x2
      x2_new = x1_new + rand(-X_LINE_LENGTH_BOUND..X_LINE_LENGTH_BOUND)
      y1_new = line.y2
      y2_new = line.y2
      line.x_moved_reset
    elsif line.x_moved_last
      x1_new = line.x2
      x2_new = line.x2
      y1_new = line.y2
      y2_new = y1_new + rand(-Y_LINE_LENGTH_BOUND..Y_LINE_LENGTH_BOUND)
      line.y_moved_reset
    else
      puts "oopsie"
    end

    new_lines << Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: "white")
  end

  lines = new_lines
  new_lines = []
  all_lines += lines
end

# update do
#   all_lines.each do |line|
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
