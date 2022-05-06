require "ruby2d"

set width: 800, height: 800, title: "Line Symmetry"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 80, 80
MAX_LINE_LENGTH = 30.0

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

gradients = [%w(white yellow orange red), %w(white aqua teal blue), %w(white fuchsia maroon purple), %w(white lime green olive)]
gradient = gradients.sample

x1_init = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
y1_init = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
x2_init, y2_init = x1_init, y1_init

line = Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")
num_of_lines = 0
line_text = Text.new("Total number of lines = #{num_of_lines}", x: Window.width / 2 - 125)

update do
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

  line = Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: line_color)
  Line.new(x1: Window.width - x1_new, y1: y1_new, x2: Window.width - x2_new, y2: y2_new, width: 1, color: line_color)
  Line.new(x1: x1_new, y1: Window.height - y1_new, x2: x2_new, y2: Window.height - y2_new, width: 1, color: line_color)
  Line.new(x1: Window.width - x1_new, y1: Window.height - y1_new, x2: Window.width - x2_new, y2: Window.height - y2_new, width: 1, color: line_color)

  num_of_lines += 4
  line_text.text = "Total number of lines = #{num_of_lines}"
end

show
