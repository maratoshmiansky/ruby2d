require "ruby2d"

set width: 600, height: 600, title: "Lines!"

X_NUM_OF_LINES, Y_NUM_OF_LINES = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 90, 90
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 2
ANGLE = ANGLE_DELTA * DEGS_TO_RADS
COS, SIN = Math.cos(ANGLE), Math.sin(ANGLE)

class Line
  def rotate
    translate_origin
    x = @x1 * COS - @y1 * SIN
    y = @x1 * SIN + @y1 * COS
    translate_center(x, y)
  end

  def translate_origin
    @x1 -= X_CENTER
    @y1 -= Y_CENTER
  end

  def translate_center(x_coord, y_coord)
    @x1 = x_coord + X_CENTER
    @y1 = y_coord + Y_CENTER
  end
end

lines = []

X_NUM_OF_LINES.times do |i|
  Y_NUM_OF_LINES.times do |j|
    x1_init = X_WINDOW_OFFSET + (i + 0.5) * VIEWPORT_WIDTH / X_NUM_OF_LINES
    y1_init = Y_WINDOW_OFFSET + (j + 0.5) * VIEWPORT_HEIGHT / Y_NUM_OF_LINES
    lines << Line.new(x1: x1_init, y1: y1_init, x2: x1_init, y2: y1_init, width: 1, color: "white")
  end
end

update do
  lines.each do |line|
    line.rotate
  end
end

show
