require "ruby2d"

set width: 600, height: 600, title: "Lines!"

X_NUM_OF_LINES, Y_NUM_OF_LINES = 8, 8
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_LINES
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_LINES
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA1, ANGLE_DELTA2 = -180.0, 1.0
ANGLE1 = ANGLE_DELTA1 * DEGS_TO_RADS
ANGLE2 = ANGLE_DELTA2 * DEGS_TO_RADS
COS1, SIN1 = Math.cos(ANGLE1), Math.sin(ANGLE1)
COS2, SIN2 = Math.cos(ANGLE2), Math.sin(ANGLE2)

class Line
  def rotate
    translate_origin
    x1_rot = @x1 * COS1 - @y1 * SIN1
    y1_rot = @x1 * SIN1 + @y1 * COS1
    x2_rot = @x2 * COS2 - @y2 * SIN2
    y2_rot = @x2 * SIN2 + @y2 * COS2
    translate_center(x1_rot, y1_rot, x2_rot, y2_rot)
  end

  def translate_origin
    @x1 -= X_CENTER
    @y1 -= Y_CENTER
    @x2 -= X_CENTER
    @y2 -= Y_CENTER
  end

  def translate_center(x1_coord, y1_coord, x2_coord, y2_coord)
    @x1, @y1 = x1_coord + X_CENTER, y1_coord + Y_CENTER
    @x2, @y2 = x2_coord + X_CENTER, y2_coord + Y_CENTER
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
  lines.each { |line| line.rotate }
end

show
