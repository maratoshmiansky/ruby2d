require "ruby2d"

set width: 600, height: 600, background: "white", title: "Flower Power"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 12
CIRCLE_RADIUS_MIN = 10.0
CIRCLE_RADIUS_MAX = 60.0
CIRCLE_RADIUS_DELTA = 1.01
FLOWER_RADIUS_MIN = 1.0
FLOWER_RADIUS_DELTA = 1.08 #1.015
NUM_OF_CIRCLES = 60

class Circle
  attr_reader :growing

  def grow
    if @radius <= CIRCLE_RADIUS_MAX
      @radius *= CIRCLE_RADIUS_DELTA
    else
      @growing = false
    end
  end

  def shrink
    if @radius >= CIRCLE_RADIUS_MIN
      @radius /= CIRCLE_RADIUS_DELTA
    else
      @growing = true
    end
  end

  def check_if_growing
    @radius <= CIRCLE_RADIUS_MAX ? @growing = true : @growing = false
  end

  def init
    @x_init = @x
    @y_init = @y
    check_if_growing
  end
end

circles = []
x_init, y_init = X_CENTER, Y_CENTER
z_depth = 0
circle_radius = CIRCLE_RADIUS_MIN
flower_radius = FLOWER_RADIUS_MIN
angle = 0

NUM_OF_CIRCLES.times do
  x_coord = x_init + flower_radius * Math.cos(angle * DEGS_TO_RADS)
  y_coord = y_init + flower_radius * Math.sin(angle * DEGS_TO_RADS)
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "navy")
  circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * 0.9, color: "fuchsia")
  angle = (angle + ANGLE_DELTA) % 360
  flower_radius *= FLOWER_RADIUS_DELTA
  circle_radius *= CIRCLE_RADIUS_DELTA
  z_depth += 2
end

circles.each do |circle|
  circle.init
end

update do
  circles.each_cons(2) do |circle|
    if circle[0].growing
      circle[0].grow
    else
      circle[0].shrink
    end

    if circle[1].growing
      circle[1].grow
    else
      circle[1].shrink
    end
  end
end

show
