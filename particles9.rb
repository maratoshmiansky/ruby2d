require "ruby2d"

set width: 600, height: 600, title: "Particles!"

NUM_OF_POINTS = 4000
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 60, 60
X_CENTER, Y_CENTER = Window.width / 2, Window.height / 2
X_CENTER_OFFSET, Y_CENTER_OFFSET = 0, 0
X_SPEED_MIN, X_SPEED_MAX, X_SPEED_DELTA = 0.0, 6.0, 2.0
Y_SPEED_MIN, Y_SPEED_MAX, Y_SPEED_DELTA = 0.0, 6.0, 2.0

class Point < Square
  def init
    @x_mult, @y_mult = [-1, 1].sample, [-1, 1].sample
    @x_speed, @y_speed = X_SPEED_MIN, Y_SPEED_MIN
    @x_accelerating, @y_accelerating = true, true
  end

  def move
    self.x += @x_mult * @x_speed
    self.y += @y_mult * @y_speed
  end

  def edge_check
    x_edge_check
    y_edge_check
  end
  
  def x_edge_check
    if x_hits_left?
      @x_mult = 1
    elsif x_hits_right?
      @x_mult = -1
    end
  end

  def y_edge_check
    if y_hits_top?
      @y_mult = 1
    elsif y_hits_bottom?
      @y_mult = -1
    end
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

  def set_accelerating
    set_x_accelerating
    set_y_accelerating
  end    
  
  def set_x_accelerating
    if @x_speed <= X_SPEED_MIN
      @x_accelerating = true
    elsif @x_speed >= X_SPEED_MAX
      @x_accelerating = false
    end    
  end    

  def set_y_accelerating
    if @y_speed <= Y_SPEED_MIN
      @y_accelerating = true
    elsif @y_speed >= Y_SPEED_MAX
      @y_accelerating = false
    end    
  end    

  def accelerate_decelerate
    x_accelerate_decelerate
    y_accelerate_decelerate
  end      
  
  def x_accelerate_decelerate
    if @x_accelerating
      @x_speed += rand(0.0..X_SPEED_DELTA)
    else
      @x_speed -= rand(0.0..X_SPEED_DELTA)
    end      
  end      

  def y_accelerate_decelerate
    if @y_accelerating
      @y_speed += rand(0.0..Y_SPEED_DELTA)
    else
      @y_speed -= rand(0.0..Y_SPEED_DELTA)
    end      
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
    point.move
    point.edge_check
    point.set_accelerating
    point.accelerate_decelerate
  end
end

show
