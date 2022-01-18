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
SWIRL_MULT_MIN, SWIRL_MULT_MAX = 0, 18
SWIRL_MULT_DELTA = 0.1

class Line
  def animate
    rotate
    get_distance
    swirl
  end

  def rotate
    translate_origin
    x = self.x2 * COS - self.y2 * SIN
    y = self.x2 * SIN + self.y2 * COS
    translate_center(x, y)
  end

  def translate_origin
    self.x2 -= X_CENTER
    self.y2 -= Y_CENTER
  end

  def translate_center(x_coord, y_coord)
    self.x2 = x_coord + X_CENTER
    self.y2 = y_coord + Y_CENTER
  end

  def get_distance
    @x_distance = X_CENTER - self.x1
    @y_distance = Y_CENTER - self.y1
    @distance = Math.sqrt(@x_distance ** 2 + @y_distance ** 2)
  end

  def swirl
    if @swirl_mult < SWIRL_MULT_MAX
      self.x1 += @swirl_mult * (@x_distance + @x_distance_init) / (@distance + @distance_init)
      self.y1 += @swirl_mult * (@y_distance + @y_distance_init) / (@distance + @distance_init)
      @swirl_mult += SWIRL_MULT_DELTA
    else
      self.x1, self.y1 = @x_init, @y_init
      @swirl_mult = SWIRL_MULT_MIN
    end
  end

  def init
    @x_init, @y_init = self.x1, self.y1
    @x_distance_init = X_CENTER - @x_init
    @y_distance_init = Y_CENTER - @y_init
    @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
    @swirl_mult = SWIRL_MULT_MIN
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

lines.each do |line|
  line.init
end

update do
  lines.each do |line|
    line.animate
  end
end

show
