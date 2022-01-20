require "ruby2d"

set width: 650, height: 600, title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 40, 40
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DISTANCE_MIN = 1
DISTANCE_DELTA = 2

class Point < Square
  attr_reader :contracting

  def get_distance
    @distance = Math.sqrt(@x_distance ** 2 + @y_distance ** 2)
  end

  def move
    self.x += @x_distance * DISTANCE_DELTA / @distance
    self.y += @y_distance * DISTANCE_DELTA / @distance
  end

  def centrify
    @x, @y = X_CENTER, Y_CENTER
  end

  def reinitialize
    @x, @y = @x_init, @y_init
  end

  def contract
    @x_distance = X_CENTER - @x
    @y_distance = Y_CENTER - @y
    get_distance

    if @distance > DISTANCE_MIN
      move
    else
      @contracting = false
      centrify
    end
  end

  def expand
    @x_distance = @x_init - @x
    @y_distance = @y_init - @y
    get_distance

    if @distance.between?(DISTANCE_MIN, @distance_init)
      move
    else
      @contracting = true
      reinitialize
    end
  end

  def init
    @x_init, @y_init = @x, @y
    @x_distance_init = X_CENTER - @x_init
    @y_distance_init = Y_CENTER - @y_init
    @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
    @contracting = true
  end
end

points = []

# set up point grid
X_NUM_OF_POINTS.times do |i|
  Y_NUM_OF_POINTS.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * VIEWPORT_WIDTH / X_NUM_OF_POINTS
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

points.each do |point|
  point.init
end

update do
  points.each do |point|
    if point.contracting
      point.contract
    else
      point.expand
    end
  end
end

show
