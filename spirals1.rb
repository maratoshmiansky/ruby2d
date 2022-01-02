require "ruby2d"

set width: 650, height: 600, title: "Spirals!"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 75, 75
X_MULT, Y_MULT = 1, 1
DEGS_TO_RADIANS = Math::PI / 180
TWO_PI = 2 * Math::PI
ANGLE_INCR = 10
RADIUS_INCR = 0.001

class Line
  def x_hits_left?
    self.x1 < X_WINDOW_OFFSET || self.x2 < X_WINDOW_OFFSET
  end

  def x_hits_right?
    self.x1 >= Window.width - X_WINDOW_OFFSET || self.x2 >= Window.width - X_WINDOW_OFFSET
  end

  def y_hits_top?
    self.y1 < Y_WINDOW_OFFSET || self.y2 < Y_WINDOW_OFFSET
  end

  def y_hits_bottom?
    self.y1 >= Window.height - Y_WINDOW_OFFSET || self.y2 >= Window.height - Y_WINDOW_OFFSET
  end
end

def line_init(line_color)
  x1_init, y1_init = Window.width / 2, Window.height / 2
  x2_init, y2_init = x1_init + 1, y1_init + 1

  draw_segment(x1_init, y1_init, x2_init, y2_init, line_color)
end

def draw_segment(x1, y1, x2, y2, line_color)
  Line.new(x1: x1, y1: y1, x2: x2, y2: y2, width: 1, color: line_color)
end

gradients = [%w(white yellow orange red), %w(white aqua teal blue), %W(white fuchsia maroon purple), %W(white lime green olive)]
gradient = gradients.sample
line_color = gradient.sample
line = line_init(line_color)
angle, radius = 0, 0
radius_incr = RADIUS_INCR

update do
  if line.x_hits_left? || line.x_hits_right? || line.y_hits_top? || line.y_hits_bottom?
    clear
    line_color = gradient.sample
    line = line_init(line_color)
    angle, radius = 0, 0
    radius_incr = RADIUS_INCR
  end

  x1_new = line.x2
  y1_new = line.y2
  x_mult = radius * X_MULT
  y_mult = radius * Y_MULT
  angle += ANGLE_INCR * DEGS_TO_RADIANS
  angle %= TWO_PI
  x_offset = x_mult * Math.cos(angle)
  y_offset = y_mult * Math.sin(angle)
  x2_new = x1_new + x_offset
  y2_new = y1_new + y_offset

  line = draw_segment(x1_new, y1_new, x2_new, y2_new, line_color)  
  puts "x1: #{line.x1.to_i}, x2: #{line.x2.to_i}, y1: #{line.y1.to_i}, y2: #{line.y2.to_i}"

  radius_incr += RADIUS_INCR
  radius += radius_incr
end

show
