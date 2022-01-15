require "ruby2d"

set width: 600, height: 600, title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 20, 20
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

class Point < Square
  def animate
    rotate
    contract_expand
  end

  def contract_expand
    if @contract_counter < ITERATIONS
      translate_origin
      @contracting ? factor = SCALE_FACTOR : factor = 1 / SCALE_FACTOR
      x = self.x * factor
      y = self.y * factor
      translate_center(x, y)
      @contract_counter += 1
    else
      @contracting ? @contracting = false : @contracting = true
      @contract_counter = 0
    end
  end

  def rotate
    translate_origin
    x = self.x * COS - self.y * SIN
    y = self.x * SIN + self.y * COS
    translate_center(x, y)
  end

  def translate_origin
    self.x -= X_CENTER
    self.y -= Y_CENTER
  end

  def translate_center(x_coord, y_coord)
    self.x = x_coord + X_CENTER
    self.y = y_coord + Y_CENTER
  end

  def init
    @contracting = true
    @contract_counter = 0
  end
end

points = []

# set up point grid
X_NUM_OF_POINTS.times do |i|
  Y_NUM_OF_POINTS.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * VIEWPORT_WIDTH / X_NUM_OF_POINTS
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

points.each do |point|
  point.init
end

update do
  points.each do |point|
    point.animate
  end
end

show
