require "ruby2d"

set width: 600, height: 600, title: "Particles!"

NUM_OF_POINTS = 100
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_CENTER_OFFSET, Y_CENTER_OFFSET = 20.0, 20.0
X_SPEED, Y_SPEED = 0.2, 0.4
Y_SPEED_MIN = 0.0
X_SPEED_MAX, Y_SPEED_MAX = 4.0, 16.0

class Point < Square
  def init
    speed_reset
  end

  def speed_reset
    x_speed_reset
    y_speed_reset
  end  
  
  def x_speed_reset
    @x_speed = rand(-X_SPEED_MAX..X_SPEED_MAX)
  end  

  def y_speed_reset
    @y_speed = rand(Y_SPEED_MIN..Y_SPEED_MAX)
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

  def accelerate
    x_accelerate
    y_accelerate
  end  
  
  def x_accelerate
    @x_speed <= X_SPEED_MAX ? @x_speed += rand(-X_SPEED..X_SPEED) : x_speed_reset
  end  

  def y_accelerate
    @y_speed <= Y_SPEED_MAX ? @y_speed += Y_SPEED : y_speed_reset
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
    point.accelerate
  end
end

show
