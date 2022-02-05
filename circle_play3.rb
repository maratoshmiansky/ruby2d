require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Play"

X_NUM_OF_CIRCLES, Y_NUM_OF_CIRCLES = 24, 8
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_CIRCLES
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 3.0
Y_AMP = 100.0
CIRCLE_RADIUS_INIT = 8.0
CIRCLE_BORDER_MULT = 0.75

class Circle
  def wave
    @angle = (@angle + ANGLE_DELTA) % 360
    @y = @y_init + Y_AMP * Math.sin(@angle * DEGS_TO_RADS)
    @radius = @radius_init * (Y_CENTER - @y).abs / Y_AMP
  end

  def init
    @x_init, @y_init = @x, @y
    @x_distance_init = X_CENTER - @x_init
    # @y_distance_init = Y_CENTER - @y_init
    # @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
    @angle = @x_distance_init * X_GRID / 30.0
    @radius_init = @radius
  end
end

circles = []
y_coord = Y_CENTER
z_depth = 0
circle_radius = CIRCLE_RADIUS_INIT

X_NUM_OF_CIRCLES.times do |i|
  x_coord = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "black")
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * CIRCLE_BORDER_MULT, color: "yellow")
  z_depth += 2
end

circles.each do |circle|
  circle.init
end

update do
  circles.each do |circle|
    circle.wave
  end
end

show
