require "ruby2d"

set width: 600, height: 600, title: "Lines!"

X_NUM_OF_LINES, Y_NUM_OF_LINES = 16, 16
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 90, 90
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_LINES
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_LINES
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 1.0
ANGLE = ANGLE_DELTA * DEGS_TO_RADS
COS, SIN = Math.cos(ANGLE), Math.sin(ANGLE)

class Line
  def rotate
    translate_origin
    x_rot = @x1 * COS - @y1 * SIN
    y_rot = @x1 * SIN + @y1 * COS
    translate_center(x_rot, y_rot)
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
    x_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
    lines << Line.new(x1: x_init, y1: y_init, x2: x_init, y2: y_init, width: 1, color: "white")
  end
end

update do
  lines.each do |line|
    line.rotate
  end
end

show
