require "ruby2d"

set width: 600, height: 600, title: "Lines1"

X_NUM_OF_LINES, Y_NUM_OF_LINES = 5, 5
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_LINES
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_LINES
MAX_LINE_MOVES = 15
MAX_ITERATIONS = 12
X_LINE_MAX_LENGTH, Y_LINE_MAX_LENGTH = 10.0, 10.0

gradients = [%w(white yellow orange red), %w(white aqua teal blue), %W(white fuchsia maroon purple), %W(white lime green olive)]
gradient = gradients.sample

num_of_iterations = 0

update do
  # set up point grid
  lines, new_lines = [], []

  X_NUM_OF_LINES.times do |i|
    Y_NUM_OF_LINES.times do |j|
      x1_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
      y1_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
      x2_init = x1_init
      y2_init = y1_init

      lines << Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")
    end
  end

  all_lines = lines

  # sprout some branches
  MAX_LINE_MOVES.times do
    lines.each do |line|
      x1_new = line.x2
      y1_new = line.y2
      line_color = gradient.sample
      # branch vertically if previous branch was horizontal and vice-versa
      if line.x1 != line.x2
        x2_new = x1_new
        y2_new = y1_new + rand(-Y_LINE_MAX_LENGTH..Y_LINE_MAX_LENGTH)
      else
        x2_new = x1_new + rand(-X_LINE_MAX_LENGTH..X_LINE_MAX_LENGTH)
        y2_new = y1_new
      end

      new_lines << Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: line_color)
    end

    lines = new_lines
    new_lines = []
    all_lines += lines
  end

  if num_of_iterations < MAX_ITERATIONS
    num_of_iterations += 1
  else
    num_of_iterations = 0
    clear
    gradient = gradients.sample
  end
end

show
