require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Play"

X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
CIRCLE_RADIUS_INIT = 2.0
CIRCLE_RADIUS_DELTA = 1.05
CIRCLE_RADIUS_MULT = 4.0
CIRCLE_BORDER_MULT = 0.8
NUM_OF_CIRCLES_INIT = 8
NUM_OF_CIRCLES_DELTA = 2
ANGLE_DELTA_INIT = 360.0 / NUM_OF_CIRCLES_INIT
RING_RADIUS_INIT = 20.0
RING_RADIUS_DELTA = 1.155
NUM_OF_RINGS = 19
ROT_ANGLE_DIV = 8

class Circle
  attr_reader :radius, :growing

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

  def rad_init
    @radius_init = @radius
    @radius_last = @radius * CIRCLE_RADIUS_MULT
    @growing = true
  end

  def rot_init(circ_radius)
    @rot_angle_delta = circ_radius / ROT_ANGLE_DIV
    @rot_angle = @rot_angle_delta * DEGS_TO_RADS
    @cos, @sin = Math.cos(@rot_angle), Math.sin(@rot_angle)
  end
end

circles = []
z_depth = 0
circle_radius = CIRCLE_RADIUS_INIT
ring_radius = RING_RADIUS_INIT
num_of_circles = NUM_OF_CIRCLES_INIT
angle_delta = ANGLE_DELTA_INIT

NUM_OF_RINGS.times do
  angle = angle_delta

  num_of_circles.times do
    x_coord = X_CENTER + ring_radius * Math.cos(angle * DEGS_TO_RADS)
    y_coord = Y_CENTER + ring_radius * Math.sin(angle * DEGS_TO_RADS)
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "black")
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * CIRCLE_BORDER_MULT, color: "purple")
    angle += angle_delta
    z_depth += 2
  end

  ring_radius *= RING_RADIUS_DELTA
  circle_radius *= CIRCLE_RADIUS_DELTA
  num_of_circles += NUM_OF_CIRCLES_DELTA
  angle_delta = 360.0 / num_of_circles
end

circles.each_slice(2) do |circle|
  circle[0].rad_init
  circle[0].rot_init(circle[0].radius)
  circle[1].rot_init(circle[0].radius)
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
    circle[0].rotate
    circle[1].rotate
  end
end

show
