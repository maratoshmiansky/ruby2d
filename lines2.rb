require "ruby2d"

set width: 650, height: 600, title: "Line Symmetry"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
X_LINE_MAX_LENGTH, Y_LINE_MAX_LENGTH = 20.0, 20.0

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

x1_init = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
y1_init = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
x2_init = x1_init
y2_init = y1_init

line = Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")

update do
  x1_new = line.x2
  y1_new = line.y2
  line_color = gradient.sample

  if line.x1 != line.x2
    x2_new = x1_new
    y_offset = rand(-Y_LINE_MAX_LENGTH..Y_LINE_MAX_LENGTH)
    y2_new = y1_new + y_offset

    if line.y_hits_top?
      y2_new += y_offset.abs
    elsif line.y_hits_bottom?
      y2_new -= y_offset.abs
    end
  else
    y2_new = y1_new
    x_offset = rand(-X_LINE_MAX_LENGTH..X_LINE_MAX_LENGTH)
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
end

show
