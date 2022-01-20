require "ruby2d"

set width: 650, height: 600, title: "Spirograph"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 75, 70
X_MULT, Y_MULT = 3, 3
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_INCR = 7
RADIUS_INCR = 1.5
X_ANGLE_MULT_MIN, X_ANGLE_MULT_MAX = 13, 44

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

def line_init(line_color)
  x1_init, y1_init = Window.width / 2, Window.height / 2
  draw_segment(x1_init, y1_init, x1_init, y1_init, line_color)
end

def draw_segment(x1, y1, x2, y2, line_color)
  Line.new(x1: x1, y1: y1, x2: x2, y2: y2, width: 1, color: line_color)
end

gradients = [%w(white yellow orange red), %w(white aqua teal blue)]
gradient = gradients.sample
line_color, line = nil, nil
angle, radius = nil, nil
x_angle_mult, y_angle_mult = X_ANGLE_MULT_MIN - 1, nil
start = true

update do
  if start
    line_color = gradient.sample
    line = line_init(line_color)
    angle, radius = 0, 0
    x_angle_mult < X_ANGLE_MULT_MAX ? x_angle_mult += 1 : x_angle_mult = X_ANGLE_MULT_MIN
    y_angle_mult = x_angle_mult
    Text.new("x_angle_mult = #{x_angle_mult}", x: Window.width / 2 - 85)
    start = false
  else
    x1_new = line.x2
    y1_new = line.y2
    radius += RADIUS_INCR
    x_mult = radius * X_MULT
    y_mult = radius * Y_MULT
    angle = (angle + ANGLE_INCR) % 360
    x_offset = x_mult * Math.cos(x_angle_mult * angle * DEGS_TO_RADIANS)
    y_offset = y_mult * Math.sin(y_angle_mult * angle * DEGS_TO_RADIANS)
    x2_new = x1_new + x_offset
    y2_new = y1_new + y_offset

    line = draw_segment(x1_new, y1_new, x2_new, y2_new, line_color)

    if line.x_hits_left? || line.x_hits_right? || line.y_hits_top? || line.y_hits_bottom?
      clear
      start = true
    end
  end
end

show
