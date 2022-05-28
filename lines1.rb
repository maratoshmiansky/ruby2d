require "ruby2d"

set width: 600, height: 600, title: "Line Symmetry"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 8, 8
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
NUM_OF_ITERATIONS = 200
MAX_LINE_LENGTH = 10.0

class Line
  def x_hits_left?
    @x1 <= X_WINDOW_OFFSET || @x2 <= X_WINDOW_OFFSET
  end

  def x_hits_right?
    @x1 >= Window.width - X_WINDOW_OFFSET || @x2 >= Window.width - X_WINDOW_OFFSET
  end

  def y_hits_top?
    @y1 <= Y_WINDOW_OFFSET || @y2 <= Y_WINDOW_OFFSET
  end

  def y_hits_bottom?
    @y1 >= Window.height - Y_WINDOW_OFFSET || @y2 >= Window.height - Y_WINDOW_OFFSET
  end
end

gradients = [%w(white yellow orange red), %w(white aqua teal blue), %W(white fuchsia maroon purple), %W(white lime green olive)]
gradient = gradients.sample
lines, new_lines, all_lines = [], [], []
iterations = 0
line_text = nil
start = true

update do
  if start
    lines = []

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
    lines.each do |line|
      x1_new, y1_new = line.x2, line.y2
      line_color = gradient.sample
      
      if line.x1 != line.x2
        x2_new = x1_new
        y_offset = rand(-MAX_LINE_LENGTH..MAX_LINE_LENGTH)
        y2_new = y1_new + y_offset
        
        if line.y_hits_top?
          y2_new += y_offset.abs
        elsif line.y_hits_bottom?
          y2_new -= y_offset.abs
        end
      else
        y2_new = y1_new
        x_offset = rand(-MAX_LINE_LENGTH..MAX_LINE_LENGTH)
        x2_new = x1_new + x_offset
        
        if line.x_hits_left?
          x2_new += x_offset.abs
        elsif line.x_hits_right?
          x2_new -= x_offset.abs
        end
      end

      new_lines << Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: line_color)
    end

    lines = new_lines
    new_lines = []
    all_lines += lines
    line_text.text = "Total number of lines = #{all_lines.length}"
  end

  if iterations < NUM_OF_ITERATIONS
    iterations += 1
  else
    iterations = 0
    clear
    gradient = gradients.sample
    start = true
  end
end

show
