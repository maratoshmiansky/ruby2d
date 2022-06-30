require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Play"

X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
CIRCLE_RADIUS_INIT, CIRCLE_RADIUS_DELTA = 3.0, 1.11
CIRCLE_INNER_MULT = 0.75
NUM_OF_CIRCLES, NUM_OF_RINGS = 13, 24
ANGLE_DELTA = 360.0 / NUM_OF_CIRCLES
RING_RADIUS_INIT, RING_RADIUS_DELTA = 10.0, 1.15
ROT_ANGLE_DIV = 30

class Circle
  attr_reader :radius

  def init(circ_radius)
    @rot_angle_delta = circ_radius / ROT_ANGLE_DIV
    @rot_angle = @rot_angle_delta * DEGS_TO_RADS
    @cos, @sin = Math.cos(@rot_angle), Math.sin(@rot_angle)
  end

  def rotate
    translate_origin
    x_rot = @x * @cos - @y * @sin
    y_rot = @x * @sin + @y * @cos
    translate_center(x_rot, y_rot)
  end

  def translate_origin
    @x -= X_CENTER
    @y -= Y_CENTER
  end

  def translate_center(x_coord, y_coord)
    @x = x_coord + X_CENTER
    @y = y_coord + Y_CENTER
  end
end

circles = []
z_depth = 0
circle_radius, ring_radius = CIRCLE_RADIUS_INIT, RING_RADIUS_INIT

NUM_OF_RINGS.times do |num|
  angle = ANGLE_DELTA
  num.odd? ? circle_color = "green" : circle_color = "fuchsia"

  NUM_OF_CIRCLES.times do
    x_coord = X_CENTER + ring_radius * Math.cos(angle * DEGS_TO_RADS)
    y_coord = Y_CENTER + ring_radius * Math.sin(angle * DEGS_TO_RADS)
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "black")
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * CIRCLE_INNER_MULT, color: circle_color)
    angle += ANGLE_DELTA
    z_depth += 2
  end

  ring_radius *= RING_RADIUS_DELTA
  circle_radius *= CIRCLE_RADIUS_DELTA
end

circles.each_slice(2) do |circle|
  circle[0].init(circle[0].radius)
  circle[1].init(circle[0].radius)
end

update do
  circles.each { |circle| circle.rotate }
end

show
