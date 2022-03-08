require "ruby2d"

set width: 600, height: 600, title: "Lines1"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 8, 8
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
NUM_OF_ITERATIONS = 150
MAX_LINE_LENGTH = 10.0

gradients = [%w(white yellow orange red), %w(white aqua teal blue), %W(white fuchsia maroon purple), %W(white lime green olive)]
gradient = gradients.sample
lines, new_lines, all_lines = [], [], []
num_of_iterations = 0
line_text = nil
start = true

update do
  if start
    lines = []
    # set up point grid
    X_NUM_OF_POINTS.times do |i|
      Y_NUM_OF_POINTS.times do |j|
        x_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
        y_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
        lines << Line.new(x1: x_init, y1: y_init, x2: x_init, y2: y_init, width: 1, color: gradient.sample)
      end
    end

    all_lines = lines
    line_text = Text.new("Total number of lines = #{all_lines.length}", x: Window.width / 2 - 125)
    start = false
  else
    # branch out
    lines.each do |line|
      x1_new = line.x2
      y1_new = line.y2
      line_color = gradient.sample
      # branch vertically if previous branch was horizontal and vice-versa
      if line.x1 != line.x2
        x2_new = x1_new
        y2_new = y1_new + rand(-MAX_LINE_LENGTH..MAX_LINE_LENGTH)
      else
        x2_new = x1_new + rand(-MAX_LINE_LENGTH..MAX_LINE_LENGTH)
        y2_new = y1_new
      end

      new_lines << Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: line_color)
    end

    lines = new_lines
    new_lines = []
    all_lines += lines
    line_text.text = "Total number of lines = #{all_lines.length}"
  end

  if num_of_iterations < NUM_OF_ITERATIONS
    num_of_iterations += 1
  else
    num_of_iterations = 0
    clear
    gradient = gradients.sample
    start = true
  end
end

show
