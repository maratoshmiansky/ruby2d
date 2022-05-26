require "ruby2d"

set width: 600, height: 600, background: "white", title: "Circle Play"

NUM_OF_CIRCLES = 60
NUM_OF_WAVES = 8
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_GRID = VIEWPORT_WIDTH / NUM_OF_CIRCLES
Y_GRID = VIEWPORT_HEIGHT / NUM_OF_WAVES
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA_MIN, ANGLE_DELTA_MAX = 0.0, 8.0
ANGLE_DELTA_DELTA = 0.05
ANGLE_DIV = 0.5
Y_AMP_INIT = 6.0
Y_AMP_DELTA = 0.15
CIRCLE_RADIUS_INIT = 20.0
CIRCLE_INNER_MULT = 0.8
RADIUS_DIV = 3.0

class Circle
  def wave
    @angle = (@angle + @angle_delta) % 360
    @y = @y_init + @y_amp * Math.sin(@angle * DEGS_TO_RADS)
    @radius = @radius_init + (@y_init - @y).abs / RADIUS_DIV
  end

  def accelerating?
    @accelerating
  end

  def faster
    @angle_delta += ANGLE_DELTA_DELTA
    @y_amp += Y_AMP_DELTA
  end  

  def slower
    @angle_delta -= ANGLE_DELTA_DELTA
    @y_amp -= Y_AMP_DELTA
  end  

  def set_accelerating
    if @angle_delta > ANGLE_DELTA_MAX
      @accelerating = false
    elsif @angle_delta < ANGLE_DELTA_MIN
      @accelerating = true
    end  
  end  

  def init
    @x_init, @y_init = @x, @y
    @angle = ((X_CENTER - @x_init) + (Y_CENTER - @y_init)) / ANGLE_DIV
    @angle_delta = ANGLE_DELTA_MIN
    @accelerating = true
    @y_amp = Y_AMP_INIT
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

circles.each { |circle| circle.init }

update do
  circles.each do |circle|
    circle.wave
    circle.accelerating? ? circle.faster : circle.slower
    circle.set_accelerating
  end
end

show
