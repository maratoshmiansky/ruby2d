require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Play"

NUM_OF_CIRCLES = 48
NUM_OF_WAVES = 8
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_GRID = VIEWPORT_WIDTH / NUM_OF_CIRCLES
Y_GRID = VIEWPORT_HEIGHT / NUM_OF_WAVES
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA_MIN = 1.0
ANGLE_DELTA_MAX = 6.0
ANGLE_DELTA_DELTA = 0.02
ANGLE_DIV = 0.5
Y_AMP = 20.0
CIRCLE_RADIUS_INIT = 20.0
CIRCLE_INNER_MULT = 0.8
RADIUS_DIV = 2.5

class Circle
  attr_reader :accel

  def wave
    @angle = (@angle + @angle_delta) % 360
    @y = @y_init + Y_AMP * Math.sin(@angle * DEGS_TO_RADS)
    @radius = @radius_init + (@y_init - @y).abs / RADIUS_DIV
  end

  def faster
    @angle_delta += ANGLE_DELTA_DELTA
  end

  def slower
    @angle_delta -= ANGLE_DELTA_DELTA
  end

  def set_accel
    if @angle_delta > ANGLE_DELTA_MAX
      @accel = false
    elsif @angle_delta < ANGLE_DELTA_MIN
      @accel = true
    end
  end

  def init
    @x_init, @y_init = @x, @y
    @angle = ((X_CENTER - @x_init) + (Y_CENTER - @y_init)) / ANGLE_DIV
    @angle_delta = ANGLE_DELTA_MIN
    @radius_init = @radius
  end
end

circles = []
z_depth = 0

NUM_OF_WAVES.times do |j|
  NUM_OF_CIRCLES.times do |i|
    i.odd? ? circle_color = "lime" : circle_color = "purple"
    x_coord = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
    y_coord = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth, radius: CIRCLE_RADIUS_INIT, color: "black")
    circles << Circle.new(x: x_coord, y: y_coord, z: z_depth + 1, radius: CIRCLE_RADIUS_INIT * CIRCLE_INNER_MULT, color: circle_color)
    z_depth += 2
  end
end

circles.each do |circle|
  circle.init
end

update do
  circles.each do |circle|
    circle.wave
    circle.set_accel

    if circle.accel
      circle.faster
    else
      circle.slower
    end
  end
end

show
