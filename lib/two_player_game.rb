require './lib/board'

class TwoPlayerGame
  include Board
  attr_accessor :finished, :winner, :turn

  def initialize
    self.turn = 1
    draw_board
    loop do
      puts "It's player #{color_turn}'s turn! Choose a column:"
      input = gets.chomp
      if valid_column(input)
        if add_piece(color_turn, input.to_i - 1)
          system "clear" or system "cls"
          self.turn += 1
          draw_board
        else
          puts "You can't place a piece in this column".red
        end
        break if finished
      else
        puts "The column you chose was invalid. Please choose a column between 1 and 7...".red
      end
    end
    print_results
  end

  def color_turn
    turn.odd? ? "X" : "O"
  end

  private

  def print_results
    if winner == "draw"
      puts "It's a draw!\n".green
    else
      puts "Player '#{winner}' wins the game!\n".green
    end
  end

  def is_draw?
    board[6].reduce(:+) == 42
  end

  def check_game(color, row, column)
    if is_draw?
      self.finished = true
      self.winner   = "draw"
    elsif vertical_count(color, row, column) == 4 ||
          horizontal_count(color, row) == 4 ||
          up_diagonal_count(color, row, column) >= 4 ||
          down_diagonal_count(color, row, column) >= 4
      self.finished = true
      self.winner   = color
    end
  end
end
