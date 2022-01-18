require "ruby2d"

set width: 600, height: 600, title: "Lines!"

X_NUM_OF_LINES, Y_NUM_OF_LINES = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 90, 90
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA1, ANGLE_DELTA2 = -0.1, 0.1
ANGLE1 = ANGLE_DELTA1 * DEGS_TO_RADS
ANGLE2 = ANGLE_DELTA2 * DEGS_TO_RADS
COS1, SIN1 = Math.cos(ANGLE1), Math.sin(ANGLE1)
COS2, SIN2 = Math.cos(ANGLE2), Math.sin(ANGLE2)

class Line
  def rotate
    translate_origin
    x1 = self.x1 * COS1 - self.y1 * SIN1
    y1 = self.x1 * SIN1 + self.y1 * COS1
    x2 = self.x2 * COS2 - self.y2 * SIN2
    y2 = self.x2 * SIN2 + self.y2 * COS2
    translate_center(x1, y1, x2, y2)
  end

  def translate_origin
    self.x1 -= X_CENTER
    self.y1 -= Y_CENTER
    self.x2 -= X_CENTER
    self.y2 -= Y_CENTER
  end

  def translate_center(x1_coord, y1_coord, x2_coord, y2_coord)
    self.x1 = x1_coord + X_CENTER
    self.y1 = y1_coord + Y_CENTER
    self.x2 = x2_coord + X_CENTER
    self.y2 = y2_coord + Y_CENTER
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
