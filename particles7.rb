require "ruby2d"

set width: 600, height: 600, background: "black", title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 60, 60
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 90, 90
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DEGS_TO_RADS = Math::PI / 180
ANGLE_DELTA = 27
ANGLE = ANGLE_DELTA * DEGS_TO_RADS
COS, SIN = Math.cos(ANGLE), Math.sin(ANGLE)
SCALE_FACTOR, ITERATIONS = 0.996, 400

class Point < Square
  def init
    @contracting = true
    @contract_counter = 0
  end

  def animate
    rotate
    contract_expand
  end

  def rotate
    translate_origin
    x_rot = @x * COS - @y * SIN
    y_rot = @x * SIN + @y * COS
    translate_center(x_rot, y_rot)
  end
  
  def contract_expand
    if @contract_counter < ITERATIONS
      translate_origin
      contracting? ? factor = SCALE_FACTOR : factor = 1 / SCALE_FACTOR
      x, y = @x * factor, @y * factor
      translate_center(x, y)
      @contract_counter += 1
    else
      contracting? ? @contracting = false : @contracting = true
      @contract_counter = 0
    end  
  end  

  def translate_origin
    @x -= X_CENTER
    @y -= Y_CENTER
  end

  def translate_center(x_coord, y_coord)
    self.x = x_coord + X_CENTER
    self.y = y_coord + Y_CENTER
  end

  def contracting?
    @contracting
  end
end

points = []

X_NUM_OF_POINTS.times do |i|
  Y_NUM_OF_POINTS.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
    color = (i + j).even? ? "red" : "white"
    points << Point.new(x: x_init, y: y_init, size: 1, color: color)
  end
end

points.each { |point| point.init }

update do
  points.each { |point| point.animate }
end

show
