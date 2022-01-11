require "ruby2d"

set width: 650, height: 600, title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 40, 40
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
MOVE_MULT = 1

class Point < Square
  attr_accessor :x_init, :y_init, :distance_init, :x_distance_init, :y_distance_init

  def get_distance
    @distance = Math.sqrt(@x_distance ** 2 + @y_distance ** 2)
  end

  def move
    self.x += MOVE_MULT * (@x_distance + @x_distance_init) / (@distance + @distance_init)
    self.y += MOVE_MULT * (@y_distance + @y_distance_init) / (@distance + @distance_init)
  end

  def animate
    @x_distance = X_CENTER - self.x
    @y_distance = Y_CENTER - self.y
    get_distance
    move
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
  point.x_init = point.x
  point.y_init = point.y
  point.x_distance_init = X_CENTER - point.x_init
  point.y_distance_init = Y_CENTER - point.y_init
  point.distance_init = Math.sqrt(point.x_distance_init ** 2 + point.y_distance_init ** 2)
end

update do
  points.each do |point|
    point.animate
  end
end

show
