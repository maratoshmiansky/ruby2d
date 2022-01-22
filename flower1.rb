require "ruby2d"

set width: 600, height: 600, background: "white", title: "Flower Power"

X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 12
CIRCLE_RADIUS_INIT = 10.0
CIRCLE_RADIUS_DELTA = 1.002
FLOWER_RADIUS_INIT = 1.0
FLOWER_RADIUS_DELTA = 1.016
NUM_OF_CIRCLES = 360

class Circle
end

def draw_circle(x_coord, y_coord, z_depth, rad, border, fill_color, border_color)
  Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: rad, color: border_color)
  Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: rad - border, color: fill_color)
end

x_init, y_init = X_CENTER, Y_CENTER
z = NUM_OF_CIRCLES
circle_radius = CIRCLE_RADIUS_INIT
flower_radius = FLOWER_RADIUS_INIT
angle = 0

NUM_OF_CIRCLES.times do
  x = x_init + flower_radius * Math.cos(angle * DEGS_TO_RADS)
  y = y_init + flower_radius * Math.sin(angle * DEGS_TO_RADS)
  draw_circle(x, y, z, circle_radius, circle_radius / 10.0, "fuchsia", "black")
  angle = (angle + ANGLE_DELTA) % 360
  flower_radius *= FLOWER_RADIUS_DELTA
  circle_radius *= CIRCLE_RADIUS_DELTA
  z -= 1
end

# update do
# end

show
