require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Swirl"

X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 30.0
CIRCLE_RADIUS_MIN, CIRCLE_RADIUS_MULT, CIRCLE_RADIUS_DELTA = 5.0, 3.0, 1.01
CIRCLE_BORDER_MULT = 0.9
SWIRL_RADIUS_MIN, SWIRL_RADIUS_DELTA = 5.0, 1.02
NUM_OF_CIRCLES = 240

class Circle
  def init
    @radius_last = @radius * CIRCLE_RADIUS_MULT
    @growing = true
  end

  def growing?
    @growing
  end
  
  def grow
    @radius *= CIRCLE_RADIUS_DELTA
  end

  def shrink
    @radius /= CIRCLE_RADIUS_DELTA
  end

  def set_growing
    if @radius < CIRCLE_RADIUS_MIN
      @growing = true
    elsif @radius > @radius_last
      @growing = false
    end
  end
end

circles = []
angle, z_depth = 0, 0
circle_radius, swirl_radius = CIRCLE_RADIUS_MIN, SWIRL_RADIUS_MIN

NUM_OF_CIRCLES.times do
  x_coord = X_CENTER + swirl_radius * Math.cos(angle * DEGS_TO_RADS)
  y_coord = Y_CENTER + swirl_radius * Math.sin(angle * DEGS_TO_RADS)
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "navy")
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * CIRCLE_BORDER_MULT, color: "fuchsia")
  angle = (angle + ANGLE_DELTA) % 360
  swirl_radius *= SWIRL_RADIUS_DELTA
  circle_radius *= CIRCLE_RADIUS_DELTA
  z_depth += 2
end

circles.each_slice(2) { |circle| circle[0].init }

update do
  circles.each_slice(2) do |circle|
    if circle[0].growing?
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
