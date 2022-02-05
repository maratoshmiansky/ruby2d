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
ANGLE_DIST_DELTA_MIN = -2.0
ANGLE_DIST_DELTA_MAX = 2.0
ANGLE_DIST_DELTA = 0.01
Y_AMP = 100.0
CIRCLE_RADIUS_INIT = 8.0
CIRCLE_BORDER_MULT = 0.75

class Circle
  attr_reader :angle_div_growing

  def wave
    @angle = (X_CENTER - @x_init) * @angle_dist_delta
    @angle = (@angle + ANGLE_DELTA) % 360
    @y = @y_init + Y_AMP * Math.sin(@angle * DEGS_TO_RADS)
    @radius = @radius_init * (@y_init - @y).abs / Y_AMP
  end

  def angle_dist_delta_increment
    @angle_dist_delta += ANGLE_DIST_DELTA
  end

  def angle_dist_delta_decrement
    @angle_dist_delta -= ANGLE_DIST_DELTA
  end

  def set_angle_div_growing
    if @angle_dist_delta < ANGLE_DIST_DELTA_MIN
      @angle_div_growing = true
    elsif @angle_dist_delta > ANGLE_DIST_DELTA_MAX
      @angle_div_growing = false
    end
  end

  def init
    @x_init, @y_init = @x, @y
    @x_distance_init = X_CENTER - @x_init
    # @y_distance_init = Y_CENTER - @y_init
    # @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
    @angle_dist_delta = ANGLE_DIST_DELTA_MIN
    @angle = @x_distance_init / @angle_dist_delta
    @radius_init = @radius
  end
end

circles = []
y_coord = Y_CENTER
z_depth = 0
circle_radius = CIRCLE_RADIUS_INIT

X_NUM_OF_CIRCLES.times do |i|
  i.odd? ? circle_color = "green" : circle_color = "fuchsia"
  x_coord = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "black")
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * CIRCLE_BORDER_MULT, color: circle_color)
  z_depth += 2
end

circles.each do |circle|
  circle.init
end

update do
  circles.each do |circle|
    if circle.angle_div_growing
      circle.angle_dist_delta_increment
    else
      circle.angle_dist_delta_decrement
    end

    circle.wave
    circle.set_angle_div_growing
  end
end

show
