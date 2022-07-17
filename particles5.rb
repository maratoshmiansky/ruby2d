require "ruby2d"

set width: 600, height: 600, title: "Particles!"

X_NUM_OF_POINTS, Y_NUM_OF_POINTS = 60, 60
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_GRID = VIEWPORT_WIDTH / X_NUM_OF_POINTS
Y_GRID = VIEWPORT_HEIGHT / Y_NUM_OF_POINTS
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
DISTANCE_MIN, MOVE_MULT = 1, 3

class Point < Square
  def init
    @x_init, @y_init = @x, @y
    @x_distance_init, @y_distance_init = X_CENTER - @x_init, Y_CENTER - @y_init
    @distance_init = Math.sqrt(@x_distance_init ** 2 + @y_distance_init ** 2)
    @contracting = true
  end

  def contract_expand
    contracting? ? contract : expand
  end
  
  def contracting?
    @contracting
  end
  
  def contract
    @x_distance, @y_distance = X_CENTER - @x, Y_CENTER - @y
    get_distance
    
    if @distance > DISTANCE_MIN
      move
    else
      @contracting = false
      centrify
    end
  end

  def expand
    @x_distance, @y_distance = @x - X_CENTER, @y - Y_CENTER
    get_distance

    if @distance < @distance_init
      move
    else
      @contracting = true
      reinitialize
    end
  end

  def get_distance
    @distance = Math.sqrt(@x_distance ** 2 + @y_distance ** 2)
  end    

  def move
    self.x += MOVE_MULT * (@x_distance_init / @distance_init).abs * (@x_distance / @distance)
    self.y += MOVE_MULT * (@y_distance_init / @distance_init).abs * (@y_distance / @distance)
  end    

  def centrify
    @x, @y = X_CENTER, Y_CENTER
  end  

  def reinitialize
    @x, @y = @x_init, @y_init
  end  
end

points = []
X_NUM_OF_POINTS.times do |i|
  Y_NUM_OF_POINTS.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * X_GRID
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * Y_GRID
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

points.each { |point| point.init }

update do
  points.each { |point| point.contract_expand }
end

show
