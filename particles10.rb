require "ruby2d"

set width: 600, height: 600, title: "Particles!"

NUM_OF_POINTS = 100
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_CENTER_OFFSET, Y_CENTER_OFFSET = 20.0, 20.0
X_SPEED = 4.0
Y_SPEED_MIN, Y_SPEED_MAX, Y_SPEED_DELTA = 0.0, 12.0, 0.2

class Point < Square
  def init
    @x_speed = rand(-X_SPEED..X_SPEED)
    @y_speed = rand(Y_SPEED_MIN..Y_SPEED_MAX)
    @y_accelerating = true
  end

  def edge_check
    x_edge_check
    y_edge_check
  end
  
  def x_edge_check
    @x_speed = -@x_speed if x_hits_left? || x_hits_right?
  end
  
  def y_edge_check
    @y_speed = -@y_speed if y_hits_top? || y_hits_bottom?
  end
  
  def x_hits_left?
    @x <= X_WINDOW_OFFSET
  end
  
  def x_hits_right?
    @x >= Window.width - X_WINDOW_OFFSET
  end
  
  def y_hits_top?
    @y <= Y_WINDOW_OFFSET
  end
  
  def y_hits_bottom?
    @y >= Window.height - Y_WINDOW_OFFSET
  end
  
  def move
    self.x += @x_speed
    self.y += @y_speed
  end  

  def set_y_accelerating
    if @y_speed < Y_SPEED_MIN
      @y_accelerating = true
    elsif @y_speed > Y_SPEED_MAX
      @y_accelerating = false
    end  
  end  

  def y_speed_up_and_down
    y_accelerating? ? @y_speed += Y_SPEED_DELTA : @y_speed -= Y_SPEED_DELTA
  end    

  def y_accelerating?
    @y_accelerating
  end
end

points = []

NUM_OF_POINTS.times do
  x_init = rand(X_CENTER - X_CENTER_OFFSET..X_CENTER + X_CENTER_OFFSET)
  y_init = rand(Y_CENTER - Y_CENTER_OFFSET..Y_CENTER + Y_CENTER_OFFSET)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
end

points.each { |point| point.init }

update do
  points.each do |point|
    point.edge_check
    point.move
    point.set_y_accelerating
    point.y_speed_up_and_down
  end
end

show
