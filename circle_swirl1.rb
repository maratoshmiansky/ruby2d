require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Swirl"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 30.0
CIRCLE_RADIUS_MIN = 10.0
CIRCLE_RADIUS_MAX = 60.0
CIRCLE_RADIUS_DELTA = 1.01
CIRCLE_RADIUS_FIN = 2.0
SWIRL_RADIUS_MIN = 5.0
SWIRL_RADIUS_DELTA = 1.02
NUM_OF_CIRCLES = 240

class Circle
  attr_reader :growing

  def grow
    @radius *= CIRCLE_RADIUS_DELTA
  end

  def shrink
    @radius /= CIRCLE_RADIUS_DELTA
  end

  def set_growing
    if @radius < [@radius_init, CIRCLE_RADIUS_MIN].min
      @growing = true
    elsif @radius > [@radius_fin, CIRCLE_RADIUS_MAX].max
      @growing = false
    end
  end

  def init
    @radius_init = @radius
    @radius_fin = @radius * CIRCLE_RADIUS_FIN
    @radius < @radius_fin ? @growing = true : @growing = false
  end
end

circles = []
x_init, y_init = X_CENTER, Y_CENTER
z_depth = 0
circle_radius = CIRCLE_RADIUS_MIN
swirl_radius = SWIRL_RADIUS_MIN
angle = 0

NUM_OF_CIRCLES.times do
  # x_coord = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
  # y_coord = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
  x_coord = x_init + swirl_radius * Math.cos(angle * DEGS_TO_RADS)
  y_coord = y_init + swirl_radius * Math.sin(angle * DEGS_TO_RADS)
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "navy")
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * 0.9, color: "fuchsia")
  angle = (angle + ANGLE_DELTA) % 360
  swirl_radius *= SWIRL_RADIUS_DELTA
  circle_radius *= CIRCLE_RADIUS_DELTA
  z_depth += 2
end

circles.each_slice(2) do |circle|
  circle[0].init
end

update do
  circles.each_slice(2) do |circle|
    if circle[0].growing
      circle[0].grow
      circle[1].grow
    else
      circle[0].shrink
      circle[1].shrink
    end

    circle[0].set_growing
  end
end

show
