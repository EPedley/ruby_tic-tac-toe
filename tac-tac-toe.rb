class Player

  def initialize(token, name)
    @token = token
    @name = name
  end

  def token
    @token
  end

  def name
    @name
  end

end

class Grid

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @values = create_grid
    @winner = ""
  end

  def rows
    @rows
  end

  def cols
    @cols
  end

  def values
    @values
  end

  def winner
    @winner
  end
    
  def create_grid
    grid = Array.new(3)

    grid_index = 1
  
    3.times do |row_index| 
      grid[row_index] = Array.new(3)
      3.times do |column_index| 
        grid[row_index][column_index] = grid_index
        grid_index += 1
      end
    end  
    grid
  end

  def show_grid
    self.values.each_with_index do |row, i|
      print row.join("\t")
      puts
      puts
    end
    return
  end

  def update_grid(token, input)
    self.values.each_with_index do |x, i|
      x.each_with_index do |y, j|
        if self.values[i][j] == input
          self.values[i][j] = token
        end
      end
    end
  end

  def is_there_a_winner
    if check_rows == true or check_columns == true or check_diagonals == true
      true
    else
      false
    end
  end

  def check_rows
    self.values.each_with_index do |x, i|
      if x.uniq.count == 1
        save_winner(x)
        return true
      end
    end 
    false
  end

  def check_columns
    cols_array = Array.new
    self.values.each_with_index do |x, i|
      temp_array = Array.new
      x.each_with_index do |y, j|
        temp_array.push(self.values[j][i])
      end
      cols_array.push(temp_array)
    end

    cols_array.each_with_index do |z, k|
      if z.uniq.count == 1
        save_winner(z)
        return true
      end
    end 
    false
      
  end

  def check_diagonals
    diagonals_array = Array.new
    left_to_right_diagonal = Array.new
    right_to_left_diagonal = Array.new
    
    self.values.each_with_index do |x, i|
      left_to_right_diagonal.push(self.values[i][i])
    end
    
    diagonals_array.push(left_to_right_diagonal)

    self.values.each_with_index do |x, i|
      right_to_left_diagonal.push(self.values[i][x.length - 1 - i])
    end

    diagonals_array.push(right_to_left_diagonal)

    diagonals_array.each_with_index do |z, k|
      if z.uniq.count == 1
        save_winner(z)
        return true
      end
    end 
    false
  end

  def save_winner(winning_line)
    if winning_line[0] == "O"
      @winner = "player 1"
    else
      @winner = "player 2"
    end
  end
    
end

def is_valid_input(user_input, grid)
  if grid.values.join.include?(user_input.to_s)
    return true
  end
  false
end

def get_player_move(player, grid)
  loop do
    puts "#{player.name.upcase()} place your #{player.token}."
    input = gets.chomp.to_i

    if is_valid_input(input, grid) == true
      puts 
      return input
    else 
      puts
      puts "INCORRECT INPUT. TRY AGAIN."
      puts
    end
  end
end

def whose_turn(round, player_1, player_2)
  if round % 2 == 0
    return player_1
  else
    return player_2
  end
end

# display

player_1 = Player.new("O", "Player 1")
player_2 = Player.new("X", "Player 2")
grid = Grid.new(3,3)
round = 0

puts
grid.show_grid
puts "Welcome to TIC TAC TOE"
puts

while grid.is_there_a_winner == false and round < 10
  player = whose_turn(round, player_1, player_2)
  player_input = get_player_move(player, grid)
  grid.update_grid(player.token, player_input)
  grid.show_grid
  round += 1  
end

if grid.is_there_a_winner == true
  puts "THE WINNER IS #{grid.winner.upcase()}!"
else
  puts "IT'S A DRAW!"
end

