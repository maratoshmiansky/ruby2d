require "ruby2d"

set width: 650, height: 600, title: "Spirals!"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 75, 75
X_MULT, Y_MULT = 3, 3
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_INCR = 6
RADIUS_INCR = 2

class Line
  def x_hits_left?
    self.x1 <= X_WINDOW_OFFSET || self.x2 <= X_WINDOW_OFFSET
  end

  def x_hits_right?
    self.x1 >= Window.width - X_WINDOW_OFFSET || self.x2 >= Window.width - X_WINDOW_OFFSET
  end

  def y_hits_top?
    self.y1 <= Y_WINDOW_OFFSET || self.y2 <= Y_WINDOW_OFFSET
  end

  def y_hits_bottom?
    self.y1 >= Window.height - Y_WINDOW_OFFSET || self.y2 >= Window.height - Y_WINDOW_OFFSET
  end
end

def line_init(line_color)
  # x1_init = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
  # y1_init = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
  x1_init, y1_init = Window.width / 2, Window.height / 2
  x2_init, y2_init = x1_init + 1, y1_init + 1
  draw_segment(x1_init, y1_init, x2_init, y2_init, line_color)
end

def draw_segment(x1, y1, x2, y2, line_color)
  Line.new(x1: x1, y1: y1, x2: x2, y2: y2, width: 1, color: line_color)
end

gradients = [%w(white yellow orange red), %w(white aqua teal blue)]
gradient = gradients.sample
line_color, line = nil, nil
angle, radius = nil, nil
x_angle_mult, y_angle_mult = nil, nil
start = true

update do
  if start
    line_color = gradient.sample
    line = line_init(line_color)
    angle, radius = 0, 0
    x_angle_mult = rand(9..44)
    y_angle_mult = x_angle_mult
    Text.new("x_angle_mult = #{x_angle_mult}", x: Window.width / 2 - 150)
    start = false
  else
    x1_new = line.x2
    y1_new = line.y2
    x_mult = radius * X_MULT
    y_mult = radius * Y_MULT
    angle = (angle + ANGLE_INCR) % 360
    x_offset = x_mult * Math.cos(x_angle_mult * angle * DEGS_TO_RADIANS)
    y_offset = y_mult * Math.sin(y_angle_mult * angle * DEGS_TO_RADIANS)
    x2_new = x1_new + x_offset
    y2_new = y1_new + y_offset

    line = draw_segment(x1_new, y1_new, x2_new, y2_new, line_color)
    puts "x1: #{line.x1.to_i}, x2: #{line.x2.to_i}, y1: #{line.y1.to_i}, y2: #{line.y2.to_i}"

    radius += RADIUS_INCR

    if line.x_hits_left? || line.x_hits_right? || line.y_hits_top? || line.y_hits_bottom?
      clear
      start = true
    end
  end
end

show
