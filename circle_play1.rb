require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Swirl"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
CIRCLE_RADIUS_INIT = 3.0
CIRCLE_RADIUS_LAST_MULT = 4.0
CIRCLE_RADIUS_DELTA = 1.08
NUM_OF_CIRCLES_INIT = 12
NUM_OF_CIRCLES_DELTA = 2.0
ANGLE_DELTA_INIT = 360 / NUM_OF_CIRCLES_INIT
NUM_OF_RINGS = 11
RING_RADIUS_INIT = 40.0
RING_RADIUS_DELTA = 1.2

class Circle
  attr_reader :growing

  def grow
    @radius *= CIRCLE_RADIUS_DELTA
  end

  def shrink
    @radius /= CIRCLE_RADIUS_DELTA
  end

  def set_growing
    if @radius < @radius_init
      @growing = true
    elsif @radius > @radius_last
      @growing = false
    end
  end

  def init
    @radius_init = @radius
    @radius_last = @radius * CIRCLE_RADIUS_LAST_MULT
    @growing = true
  end
end

circles = []
x_init, y_init = X_CENTER, Y_CENTER
z_depth = 0
circle_radius = CIRCLE_RADIUS_INIT
ring_radius = RING_RADIUS_INIT
num_of_circles = NUM_OF_CIRCLES_INIT
angle_delta = ANGLE_DELTA_INIT

NUM_OF_RINGS.times do
  angle = angle_delta

  num_of_circles.times do
    x_coord = x_init + ring_radius * Math.cos(angle * DEGS_TO_RADS)
    y_coord = y_init + ring_radius * Math.sin(angle * DEGS_TO_RADS)
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "black")
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * 0.8, color: "purple")
    angle += angle_delta
    z_depth += 2
  end

  ring_radius *= RING_RADIUS_DELTA
  circle_radius *= CIRCLE_RADIUS_DELTA
  num_of_circles += NUM_OF_CIRCLES_DELTA
  angle_delta = 360 / num_of_circles
  num_of_circles = num_of_circles.ceil
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
