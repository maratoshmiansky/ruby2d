require "ruby2d"

set width: 650, height: 600, title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 40, 40
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
MOVE_MULT = 5

class Point < Square
  def init
    @x_init, @y_init = @x, @y
    @x_distance_init = X_CENTER - @x_init
    @y_distance_init = Y_CENTER - @y_init
    @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
  end

  def animate
    get_distance
    move
  end

  def get_distance
    @x_distance, @y_distance = X_CENTER - @x, Y_CENTER - @y
    @distance = Math.sqrt(@x_distance ** 2 + @y_distance ** 2)
  end

  def move
    self.x += MOVE_MULT * (@x_distance + @x_distance_init) / (@distance + @distance_init)
    self.y += MOVE_MULT * (@y_distance + @y_distance_init) / (@distance + @distance_init)
  end
end

points = []

X_NUM_OF_POINTS.times do |i|
  Y_NUM_OF_POINTS.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

points.each { |point| point.init }

update do
  points.each { |point| point.animate }
end

show
