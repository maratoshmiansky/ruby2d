require "ruby2d"

set width: 640, height: 600, title: "Lines1"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 100, 100
X_LINE_MAX_LENGTH, Y_LINE_MAX_LENGTH = 40.0, 40.0

class Line
  def x_edge_check
    unless self.x1.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET) || self.x2.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET)
      self.x1 = -self.x1
      self.x2 = -self.x2
    end
  end

  def y_edge_check
    unless self.y1.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET) || self.y2.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET)
      self.y1 = -self.y1
      self.y2 = -self.y2
    end
  end
end

x_viewport_adj = (Window.width - X_WINDOW_OFFSET)
y_viewport_adj = (Window.height - Y_WINDOW_OFFSET)

# gradients = [%w(white yellow orange red), %w(white aqua teal blue), %W(white fuchsia maroon purple), %W(white lime green olive)]
# gradient = gradients.sample

x1_init = X_WINDOW_OFFSET + rand(0..x_viewport_adj)
y1_init = Y_WINDOW_OFFSET + rand(0..y_viewport_adj)
x2_init = x1_init + 1
y2_init = y1_init + 1

line = Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")

update do
  # sprout some branches
  x1_new = line.x2
  y1_new = line.y2
  # line_color = gradient.sample
  # branch vertically if previous branch was horizontal and vice-versa 
  if line.x1 != line.x2
    x2_new = x1_new
    y2_new = y1_new + rand(-Y_LINE_MAX_LENGTH..Y_LINE_MAX_LENGTH)
  else
    x2_new = x1_new + rand(-X_LINE_MAX_LENGTH..X_LINE_MAX_LENGTH)
    y2_new = y1_new
  end
  
  line.x_edge_check
  line.y_edge_check

  line = Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: "white")  
end
  
show
