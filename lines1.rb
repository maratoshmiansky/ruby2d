require "ruby2d"

set width: 660, height: 600, title: "Lines1"

NUM_OF_LINES = 25
MAX_LINE_MOVES = 15
MAX_ITERATIONS = 12
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 100, 100
X_LINE_MAX_LENGTH, Y_LINE_MAX_LENGTH = 10.0, 10.0

grid_square = Math.sqrt(NUM_OF_LINES).floor
x_viewport_adj = (Window.width - X_WINDOW_OFFSET)
y_viewport_adj = (Window.height - Y_WINDOW_OFFSET)

gradients = [%w(white yellow orange red), %w(white aqua teal blue), %W(white fuchsia maroon purple), %W(white lime green olive)]
gradient = gradients.sample

num_of_iterations = 0

update do
  # set up point grid
  lines, new_lines = [], []
  
  grid_square.times do |i|
    grid_square.times do |j|
      x1_init = X_WINDOW_OFFSET + grid_square * i * x_viewport_adj / NUM_OF_LINES
      y1_init = Y_WINDOW_OFFSET + grid_square * j * y_viewport_adj / NUM_OF_LINES
      x2_init = x1_init + 1
      y2_init = y1_init + 1
      
      lines << Line.new(x1: x1_init, y1: y1_init, x2: x2_init, y2: y2_init, width: 1, color: "white")
    end
  end
  
  all_lines = lines
  
  # sprout some branches
  MAX_LINE_MOVES.times do 
    lines.each do |line|
      x1_new = line.x2
      y1_new = line.y2
      line_color = gradient.sample
      # branch vertically if previous branch was horizontal and vice-versa 
      if line.x1 != line.x2
        x2_new = x1_new
        y2_new = y1_new + rand(-Y_LINE_MAX_LENGTH..Y_LINE_MAX_LENGTH)
      else
        x2_new = x1_new + rand(-X_LINE_MAX_LENGTH..X_LINE_MAX_LENGTH)
        y2_new = y1_new
      end
  
      new_lines << Line.new(x1: x1_new, y1: y1_new, x2: x2_new, y2: y2_new, width: 1, color: line_color)
    end
    
    lines = new_lines
    new_lines = []
    all_lines += lines  
  end

  if num_of_iterations < MAX_ITERATIONS
    num_of_iterations += 1
  else
    num_of_iterations = 0
    clear
    gradient = gradients.sample
  end
end
  
show
