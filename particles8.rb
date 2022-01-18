require "ruby2d"

set width: 600, height: 600, title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 20, 20
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 90, 90
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 4
ANGLE = ANGLE_DELTA * DEGS_TO_RADS
COS, SIN = Math.cos(ANGLE), Math.sin(ANGLE)
SWIRL_MULT_MIN, SWIRL_MULT_MAX = 10, 20
SWIRL_MULT_DELTA = 0.1

class Point < Square
  def animate
    rotate
    get_distance
    swirl
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

  def get_distance
    @x_distance = X_CENTER - self.x
    @y_distance = Y_CENTER - self.y
    @distance = Math.sqrt(@x_distance ** 2 + @y_distance ** 2)
  end

  def swirl
    if @swirl_mult < SWIRL_MULT_MAX
      self.x += @swirl_mult * (@x_distance + @x_distance_init) / (@distance + @distance_init)
      self.y += @swirl_mult * (@y_distance + @y_distance_init) / (@distance + @distance_init)
      @swirl_mult += SWIRL_MULT_DELTA
    else
      self.x, self.y = @x_init, @y_init
      @swirl_mult = SWIRL_MULT_MIN
    end
  end

  def init
    @x_init, @y_init = self.x, self.y
    @x_distance_init = X_CENTER - @x_init
    @y_distance_init = Y_CENTER - @y_init
    @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
    @swirl_mult = SWIRL_MULT_MIN
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