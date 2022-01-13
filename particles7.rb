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
DISTANCE_DIV = 60

class Point < Square
  def animate
    rotate
    get_distance
    @contracting ? contract : expand
  end

  def contract
    if @contract_counter < DISTANCE_DIV
      self.x += @x_delta
      self.y += @y_delta
      @contract_counter += 1
    else
      @contracting = false
      @contract_counter = 0
      self.color = "red"
    end
  end

  def expand
    if @contract_counter < DISTANCE_DIV
      self.x -= @x_delta
      self.y -= @y_delta
      @contract_counter += 1
    else
      @contracting = true
      @contract_counter = 0
      self.color = "white"
    end
  end

  def rotate
    self.x -= X_CENTER
    self.y -= Y_CENTER
    x = self.x * COS - self.y * SIN
    y = self.x * SIN + self.y * COS
    self.x = x + X_CENTER
    self.y = y + Y_CENTER
  end

  def get_distance
    @x_distance = X_CENTER - self.x
    @y_distance = Y_CENTER - self.y
    @distance = Math.sqrt(@x_distance ** 2 + @y_distance ** 2)
  end

  def init
    @x_init, @y_init = self.x, self.y
    @x_distance_init = X_CENTER - @x_init
    @y_distance_init = Y_CENTER - @y_init
    @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
    @x_delta = @x_distance_init / DISTANCE_DIV
    @y_delta = @y_distance_init / DISTANCE_DIV
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
