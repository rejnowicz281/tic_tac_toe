class Player
  attr_reader :name, :sign 
  def initialize(name, sign)
    @name = name 
    @sign = sign
  end 
end     

class TicTacToe
  def initialize
    print "Type in name for player1: "; player1_name = gets.chomp
    print "Type in sign for player1: "; player1_sign = choose_sign
        
    print "Type in name for player2: "; player2_name = gets.chomp
    print "Type in sign for player2: " 
    player2_sign = choose_sign
    while player2_sign == player1_sign
      print "You can't have the same signs. Choose another one: "; player2_sign = choose_sign
    end 

    @players = [Player.new(player1_name, player1_sign), Player.new(player2_name, player2_sign)]
    @board_grids = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end 

  def show_board 
    puts 
    puts "-------------"
    puts "| #{@board_grids[0]} | #{@board_grids[1]} | #{@board_grids[2]} | "
    puts "-------------"
    puts "| #{@board_grids[3]} | #{@board_grids[4]} | #{@board_grids[5]} | "
    puts "-------------"
    puts "| #{@board_grids[6]} | #{@board_grids[7]} | #{@board_grids[8]} | "
    puts "-------------"
    puts 
  end 

  def start
    puts "Choosing random player..."
    starting_player = @players.sample
    puts "The starting player is #{starting_player.name}"
    puts "Lets begin!"
    play_round(starting_player)
  end

  private
  def reset_board
    @board_grids = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end 

  def choose_sign
    sign = gets.chomp 
    sign = sign.split("").shift # make sure its only one element
    sign
  end 

  def win?(player)
    (@board_grids[0] == player.sign && @board_grids[1] == player.sign && @board_grids[2] == player.sign) ||
    (@board_grids[3] == player.sign && @board_grids[4] == player.sign && @board_grids[5] == player.sign) ||
    (@board_grids[6] == player.sign && @board_grids[7] == player.sign && @board_grids[8] == player.sign) ||
    (@board_grids[0] == player.sign && @board_grids[3] == player.sign && @board_grids[6] == player.sign) ||
    (@board_grids[1] == player.sign && @board_grids[4] == player.sign && @board_grids[7] == player.sign) ||
    (@board_grids[2] == player.sign && @board_grids[5] == player.sign && @board_grids[8] == player.sign) ||
    (@board_grids[0] == player.sign && @board_grids[4] == player.sign && @board_grids[8] == player.sign) ||
    (@board_grids[2] == player.sign && @board_grids[4] == player.sign && @board_grids[6] == player.sign)
  end 

  def choose_grid
    print "Choose your grid: (0 to 8, left to right): "
    grid_id = gets; grid_id = grid_id.to_i
    if @board_grids[grid_id] != " " || grid_id < 0 || grid_id > 8
      return choose_grid 
    else
      return grid_id
    end 
  end

  def update_grid(grid_id, sign)
    @board_grids[grid_id] = sign
  end 

  def board_full?
    @board_grids.all? { |grid| grid != " "}
  end 

  def play_round(player)
    show_board
    
    puts "Current player: #{player.name} (#{player.sign})"

    update_grid(choose_grid, player.sign)

    if win?(player)
      show_board
      puts "#{player.name} (#{player.sign}) wins this game!"
      reset_board
      print "Would you like to play again? (yes, no): "; play_again = gets.chomp
      return play_again == "yes" ? start : 0
    elsif board_full?
      show_board
      reset_board
      print "It's a draw! Would you like to play again? (yes, no): "; play_again = gets.chomp
      return play_again == "yes" ? start : 0
    else
      play_round(@players[@players.index(player)-1]) # play a round as the other player
    end 
  end 
end

game = TicTacToe.new
puts ""
game.start