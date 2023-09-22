require 'colorize'

# will add documentation later
module Messages
  def show_colors
    puts '  1  '.colorize(:black).on_white + '  2  '.colorize(:black).on_light_red +
         '  3  '.colorize(:black).on_yellow + '  4  '.colorize(:black).on_magenta +
         '  5  '.colorize(:black).on_green + '  6  '.colorize(:black).on_cyan
    puts 'Please enter a four digit code (only enter numbers).'
  end
end

# will add documentation later
class GameStart
  attr_reader :choice

  def greetings
    puts '## Welcome to my amazingly coded game of "Mastermind"! ##'
    puts 'Would you like to be the CODEMAKER, or the CODEBREAKER?'
    puts 'Type "1" for CODEMAKER, or "2" for CODEBREAKER.'
  end

  def game_choice
    @choice = gets.chomp
    if @choice == '1'
      puts "You're the CODEMAKER! Pick your code and good luck!"
    elsif @choice == '2'
      puts "You're the CODEBREAKER! Good luck cracking that code!"
    else
      puts 'Please pick a valid option. Type "1" for CODEMAKER, or "2" for CODEBREAKER.'
      game_choice
    end
  end
end

# will add documentation later
class Computer
  attr_reader :mastermind_code

  def build_mastermind_code
    @mastermind_code = []
    @mastermind_code.push(rand(1..6).to_s) until @mastermind_code.length == 4
  end
end

# will add documentation later
class Player
  include Messages

  def initialize(mastermind_code)
    @mastermind_code = mastermind_code
    p @mastermind_code
  end

  def guessing
    show_colors
    @guess = gets.chomp.to_s.split('')
    puts 'Invalid code. Please enter a four digit code.' && guessing unless @guess.length == 4
  end

  def code_broken?
    (1..11).each do |i|
      if @guess == @mastermind_code
        puts 'You broke the code! Great job!'
        break
      elsif i <= 10 && @guess != @mastermind_code
        puts "Not quite. Try again! You have #{10 - i} tries left!"
        getting_tips(@guess, @mastermind_code)
      elsif i == 11 && @guess != @mastermind_code
        puts "You didn't manage to break the code. Good luck next time!"
      end
    end
  end

  def getting_tips(guess, code)
    tempguess = guess.dup
    tempcode = code.dup

    3.downto(0) do |i|
      if tempguess[i] == tempcode[i]
        tempcode.delete_at(i)
        tempguess.delete_at(i)
        puts 'o'.red
      end
    end

    3.downto(0) do |i|
      if tempcode.include?(tempguess[i])
        puts 'o'
        tempcode.delete_at(i)
        tempguess.delete_at(i)
      end
    end

    guessing
  end
end

newgame = GameStart.new
newgame.greetings
newgame.game_choice

if newgame.choice == '2'
  codemaster = Computer.new
  codemaster.build_mastermind_code
  codebreaker = Player.new(codemaster.mastermind_code)
  codebreaker.guessing
  codebreaker.code_broken?
end

# puts '  1  '.on_red
# puts 'ooo'.red + 'o'.white