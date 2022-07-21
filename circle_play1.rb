require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Play"

X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
CIRCLE_RADIUS_INIT, CIRCLE_RADIUS_DELTA, CIRCLE_RADIUS_MULT = 2.0, 1.05, 4.0
CIRCLE_INNER_MULT = 0.8
NUM_OF_CIRCLES_INIT, NUM_OF_CIRCLES_DELTA = 12, 2
ANGLE_DELTA_INIT = 360.0 / NUM_OF_CIRCLES_INIT
RING_RADIUS_INIT, RING_RADIUS_DELTA = 20.0, 1.155
NUM_OF_RINGS = 19
ROT_ANGLE_DIV = 4

class Circle
  attr_reader :radius

  def rad_init
    @radius_init, @radius_last = @radius, @radius * CIRCLE_RADIUS_MULT
    @growing = true
  end

  def rot_init(circ_radius)
    @rot_angle_delta = circ_radius / ROT_ANGLE_DIV
    @rot_angle = @rot_angle_delta * DEGS_TO_RADS
    @cos, @sin = Math.cos(@rot_angle), Math.sin(@rot_angle)
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
    if @radius < @radius_init
      @growing = true
    elsif @radius > @radius_last
      @growing = false
    end
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
num_of_circles, angle_delta = NUM_OF_CIRCLES_INIT, ANGLE_DELTA_INIT

NUM_OF_RINGS.times do
  angle = angle_delta

  num_of_circles.times do
    x_coord = X_CENTER + ring_radius * Math.cos(angle * DEGS_TO_RADS)
    y_coord = Y_CENTER + ring_radius * Math.sin(angle * DEGS_TO_RADS)
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: circle_radius, color: "black")
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: circle_radius * CIRCLE_INNER_MULT, color: "purple")
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
    if circle[0].growing?
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
