class TicTacToe

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

  def initialize(board = nil)
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
   puts "-----------"
   puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
   puts "-----------"
   puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    @input = input.to_i
    @input = @input - 1
  end

  def move(index,token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    if(@board[index] != " ")
      true
    else
      false
    end
  end

  def valid_move?(index)
    if(@board[index] == " " && index>=0 && index<=8 )
      true
    else
      false
    end
  end

  def turn_count
    @count = 0
    @board.each { |e|
      if e != " "
        @count+=1
      end
    }
    @count
  end

  def current_player
    if(turn_count.even?)
      "X"
    else
      "O"
    end
  end

  def turn
    input = gets.strip
    @input_to_index = input_to_index(input)
    @valid_move = valid_move?(@input_to_index)
    @current_player = current_player

    if(@valid_move)
      move(@input_to_index,@current_player)
      display_board
    else
      puts "invalid"
      input = gets.strip
    end
  end

  def won?
    winning = []
    WIN_COMBINATIONS.each_with_index { |combination,i|
      winning[i] = []
      combination.each{ |index|
        if(@board[index] == "X") # Check if X is the winner
          winning[i] << combination
        else
          winning[i] << false
        end
      }
    }

    winning = winning.find {|e| !e.include?(false)}
    if(winning)
      winning[0]
    else # if_not, then it checks if O is the winner and show our final result
      winning = []
      WIN_COMBINATIONS.each_with_index { |combination,i|
        winning[i] = []
        combination.each{ |index|
          if(@board[index] == "O")
            winning[i] << combination
          else
            winning[i] << false
          end
        }
      }
      winning = winning.find {|e| !e.include?(false)}
      if(winning)
        winning[0]
      else
        winning
      end
    end
  end

  def full?
    if(@board.any? { |e| e==" " })
      false
    elsif(!won?)
      true
    end
  end

  def draw?
    if(won?)
      false
    else
      true
    end
  end

  def over?
    if(@board.any? { |e| e==" " })
      false
    elsif(draw? || won?)
      true
    end
  end

  def winner
    if(won?)
      winning = @board[won?[0]]
      if winning.include?("X")
        "X"
      elsif winning.include?("O")
        "O"
      end
    else
      nil
    end
  end

  def play

    counter = 0
    until counter == 9
      if(!over?)
        if !won?
          turn
        end
    elsif won?
       puts "Congratulations #{winner}!"
    elsif draw?
       puts "Cats Game!"
    end
      counter += 1
    end




  end
end
