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
SCALE_FACTOR = 0.98
ITERATIONS = 180

class Line
  def animate
    rotate
  end

  def rotate
    translate_origin
    x1 = self.x1 * COS - self.y1 * SIN
    y1 = self.x1 * SIN + self.y1 * COS
    x2 = self.x2 * COS - self.y2 * SIN
    y2 = self.x2 * SIN + self.y2 * COS
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

    if (i + j).even?
      x2_init, y2_init = X_WINDOW_OFFSET, Y_WINDOW_OFFSET
    else
      x2_init, y2_init = Window.width - X_WINDOW_OFFSET, Window.width - Y_WINDOW_OFFSET
    end

    lines << Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")
  end
end

update do
  lines.each do |line|
    line.animate
  end
end

show
