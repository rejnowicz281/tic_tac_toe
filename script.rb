class Board
  @@win_conditions = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]
  def initialize
    @grids = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def show_board
    puts ""
    puts "-------------------"
    puts "|  #{@grids[0]}  |  #{@grids[1]}  |  #{@grids[2]}  |    0      1      2"
    puts "-------------------"
    puts "|  #{@grids[3]}  |  #{@grids[4]}  |  #{@grids[5]}  |    3      4      5      <--- ID's for the grids"
    puts "-------------------"
    puts "|  #{@grids[6]}  |  #{@grids[7]}  |  #{@grids[8]}  |    6      7      8"
    puts "-------------------"
    puts ""
  end
  
  def update_grid(mark, grid_id)
    @grids[grid_id] = mark
  end
  
  def is_full?
    @grids.all? { |grid| grid != " "}
  end

  def grid_taken?(grid_id)
    @grids[grid_id] != " "
  end

  def win_conditions
    @@win_conditions
  end
end

class Player
  attr_reader :mark, :name, :moves
  def initialize(name, mark)
    @name = name
    @mark = mark
    @moves = []
  end

  def check_for_win
      @moves.include?(0) && @moves.include?(1) && @moves.include?(2) || 
      @moves.include?(3) && @moves.include?(4) && @moves.include?(5) ||
      @moves.include?(6) && @moves.include?(7) && @moves.include?(8) || 
      @moves.include?(0) && @moves.include?(3) && @moves.include?(6) ||
      @moves.include?(1) && @moves.include?(4) && @moves.include?(7) ||
      @moves.include?(2) && @moves.include?(5) && @moves.include?(8) ||
      @moves.include?(0) && @moves.include?(4) && @moves.include?(8) ||
      @moves.include?(2) && @moves.include?(4) && @moves.include?(6) # if @moves includes these grid ids the player wins
  end
end

def game
  print "Player One name: "; player1_name = gets.chomp
  player1 = Player.new(player1_name, "X")

  print "Player Two name: "; player2_name = gets.chomp
  player2 = Player.new(player2_name, "O")

  board = Board.new

  def choose_grid(player, board)
    print "Type in the id of your grid of choice, #{player.name} (#{player.mark}): "; grid_id = gets
    grid_id = grid_id.to_i

    if grid_id > 8 || board.grid_taken?(grid_id)
      puts "That grid is unavailable."
      choose_grid(player, board)
    else
      board.update_grid(player.mark, grid_id)
      player.moves << grid_id
    end
  end

  puts "\nNOTE: Typing in a string will default to 0"

  tries = 0
  until board.is_full? || player1.check_for_win || player2.check_for_win
    board.show_board
    choose_grid(player1, board) if tries.even?
    choose_grid(player2, board) if tries.odd?
    tries += 1

    if player1.check_for_win
      board.show_board
      puts "#{player1.name} (#{player1.mark}) wins!"
    elsif player2.check_for_win
      board.show_board
      puts "#{player2.name} (#{player2.mark}) wins!"
    else
      board.show_board
      puts "It's a draw"
    end
  end
end

game