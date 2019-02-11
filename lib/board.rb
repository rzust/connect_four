module Board
  def board
    @board ||= generate_board
  end

  def generate_board
    board = Array.new(6) { Array.new(7, "_") }
    board.push(Array.new(7, 0))
  end

  def draw_board
    (0..5).each do |row|
      board[row].each do |column|
        case column
        when "X"
          print(column.to_s.red)
        when "O"
          print(column.to_s.yellow)
        else
          print(column.to_s)
        end
        print " "
      end
      print "\n"
    end
    puts "1 2 3 4 5 6 7\n\n"
  end

  def add_piece(color, column)
    row = 5 - board[6][column]
    unless row < 0
      board[row][column] = color
      board[6][column] += 1
      check_game(color, row, column)
      return true
    end
  end

  def valid_column(input)
    input.to_i.between?(1, 7)
  end

  def vertical_count(color, row, column)
    counter = 0
    row.upto(5).each do |x|
      break unless board[x][column] == color
      counter += 1
    end
    counter
  end

  def horizontal_count(color, row)
    counter = 0
    (0..6).each do |x|
      board[row][x] == color ? counter += 1 : counter = 0
      break if counter == 4
    end
    counter
  end

  def up_diagonal_count(color, row, column)
    northeast, southwest = 0, 0
    while row - northeast >= 0 && column + northeast < 7
      break unless board[row - northeast][column + northeast] == color
      northeast += 1
    end
    while row + southwest < 6 && column - southwest >= 0
      break unless board[row + southwest][column - southwest] == color
      southwest += 1
    end
    northeast + southwest - 1
  end

  def down_diagonal_count(color, row, column)
    northwest, southeast = 0, 0
    while row - northwest >= 0 && column - northwest >= 0
      break unless board[row - northwest][column - northwest] == color
      northwest += 1
    end
    while row + southeast < 6 && column + southeast < 7
      break unless board[row + southeast][column + southeast] == color
      southeast += 1
    end
    northwest + southeast - 1
  end
end
