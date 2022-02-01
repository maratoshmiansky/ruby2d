require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Swirl"

X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 62.0
CIRCLE_RADIUS_MIN = 5.0
CIRCLE_RADIUS_MULT = 2.0
CIRCLE_RADIUS_DELTA = 1.012
SWIRL_RADIUS_MIN = 5.0
SWIRL_RADIUS_DELTA = 1.021
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
    if @radius < CIRCLE_RADIUS_MIN * CIRCLE_RADIUS_MULT
      @growing = true
    elsif @radius > @radius_last
      @growing = false
    end
  end

  def init
    @radius_init = @radius
    @radius_last = @radius * CIRCLE_RADIUS_MULT
    @growing = true
  end
end

circles = []
x_init, y_init = X_CENTER, Y_CENTER
z_depth = 0
circle_radius = CIRCLE_RADIUS_MIN
swirl_radius = SWIRL_RADIUS_MIN
angle = 0

NUM_OF_CIRCLES.times do
  x_coord = x_init + swirl_radius * Math.cos(angle * DEGS_TO_RADS)
  y_coord = y_init + swirl_radius * Math.sin(angle * DEGS_TO_RADS)
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "red")
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * 0.9, color: "black")
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
