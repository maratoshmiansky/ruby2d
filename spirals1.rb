require "ruby2d"

set width: 600, height: 600, title: "Spirograph"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_DELTA, RADIUS_DELTA = 7, 4
ANGLE_MULT_MIN, ANGLE_MULT_MAX, ANGLE_MULT_DELTA = 13, 44, 1

class Line
  def hits_any?
    hits_left? || hits_right? || hits_top? || hits_bottom?
  end
  
  def hits_left?
    @x1 <= X_WINDOW_OFFSET || @x2 <= X_WINDOW_OFFSET
  end

  def hits_right?
    @x1 >= Window.width - X_WINDOW_OFFSET || @x2 >= Window.width - X_WINDOW_OFFSET
  end

  def hits_top?
    @y1 <= Y_WINDOW_OFFSET || @y2 <= Y_WINDOW_OFFSET
  end

  def hits_bottom?
    @y1 >= Window.height - Y_WINDOW_OFFSET || @y2 >= Window.height - Y_WINDOW_OFFSET
  end
end

def line_init(line_color)
  x_init, y_init = Window.width / 2, Window.height / 2
  draw_segment(x_init, y_init, x_init, y_init, line_color)
end

def draw_segment(x1, y1, x2, y2, line_color)
  Line.new(x1: x1, y1: y1, x2: x2, y2: y2, width: 1, color: line_color)
end

gradients = [%w(white yellow orange red), %w(white aqua teal blue)]
gradient = gradients.sample
line_color, line = "", nil
angle, radius = 0, 0
angle_mult = ANGLE_MULT_MIN - ANGLE_MULT_DELTA
start = true

update do
  if start
    line_color = gradient.sample
    line = line_init(line_color)
    angle, radius = 0, 0
    angle_mult < ANGLE_MULT_MAX ? angle_mult += ANGLE_MULT_DELTA : angle_mult = ANGLE_MULT_MIN    
    Text.new("angle_mult = #{angle_mult}", x: Window.width / 2 - 75)
    start = false
  else
    x1_new, y1_new = line.x2, line.y2
    radius += RADIUS_DELTA
    angle = (angle + ANGLE_DELTA) % 360
    rot_angle = angle_mult * angle * DEGS_TO_RADIANS
    x2_new = x1_new + radius * Math.cos(rot_angle)
    y2_new = y1_new + radius * Math.sin(rot_angle)

    line = draw_segment(x1_new, y1_new, x2_new, y2_new, line_color)

    if line.hits_any?
      clear
      start = true
    end
  end
end

show
