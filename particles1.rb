require "ruby2d"

set title: "Particles!", width: 600, height: 600

NUM_OF_POINTS = 5000
X_MOVE_BOUND, Y_MOVE_BOUND = 3.0, 3.0

class Point < Square
  def init
    x_move_reset
    y_move_reset
  end

  def x_move_reset
    @x_move = rand(-X_MOVE_BOUND..X_MOVE_BOUND)
  end    

  def y_move_reset
    @y_move = rand(-Y_MOVE_BOUND..Y_MOVE_BOUND)
  end

  def bounce
    x_bounce
    y_bounce
  end
  
  def x_bounce
    unless @x.between?(0, Window.width)
      @x_move = -@x_move
      color_swap
    end
  end

  def y_bounce
    unless @y.between?(0, Window.height)
      @y_move = -@y_move
      color_swap
    end
  end

  def color_swap
    self.color = ["white", "aqua", "teal", "blue"].sample
  end

  def move
    self.x += @x_move
    self.y += @y_move
  end    
end

points = []

NUM_OF_POINTS.times do
  x_init, y_init = rand(0..Window.width), rand(0..Window.height)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
end

points.each { |point| point.init }

update do
  points.each do |point|
    point.bounce
    point.move
  end
end

show
