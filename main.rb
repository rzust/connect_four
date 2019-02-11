require 'colorize'
require './lib/two_player_game'

class App
  def initialize
    puts 'Welcome to Connect-Four in Ruby!'
    loop do
      puts "To start the game press the 'Enter' key. For help type 'help', to exit type 'exit'"
      input = gets
      case input
      when /\Ahelp\n\z/m
        puts "Help: ..."
      when /\Aexit\n\z/m
        abort
      when "\n"
        TwoPlayerGame.new
      end
    end
  end
end

App.new
