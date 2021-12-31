require "ruby2d"

set width: 640, height: 600, title: "Lines1"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 100, 100
X_LINE_MAX_LENGTH, Y_LINE_MAX_LENGTH = 40.0, 40.0

class Line
  def x_in_bounds?
    self.x1.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET) && self.x2.between?(X_WINDOW_OFFSET, Window.width - X_WINDOW_OFFSET)
  end

  def y_in_bounds?
    self.y1.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET) && self.y2.between?(Y_WINDOW_OFFSET, Window.height - Y_WINDOW_OFFSET)
  end
end

# gradients = [%w(white yellow orange red), %w(white aqua teal blue), %W(white fuchsia maroon purple), %W(white lime green olive)]
# gradient = gradients.sample

x1_init = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
y1_init = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
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
    y_offset = rand(-Y_LINE_MAX_LENGTH..Y_LINE_MAX_LENGTH)
    y2_new = y1_new + y_offset
    # check if y outside viewport
    if !line.y_in_bounds?
      # y2_new = y1_new - y_offset
      y2_new = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
    end

    x2_new = x1_new
    p line.y_in_bounds?
  else
    x_offset = rand(-X_LINE_MAX_LENGTH..X_LINE_MAX_LENGTH)
    x2_new = x1_new + x_offset
    # check if x outside viewport
    if !line.x_in_bounds?
      # x2_new = x1_new - x_offset
      x2_new = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
    end

    y2_new = y1_new
    p line.x_in_bounds?
  end

  line = Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: "white")  
  puts "x1: #{line.x1.to_i}, x2: #{line.x2.to_i}, y1: #{line.y1.to_i}, y2: #{line.y2.to_i}"
end
  
show
