# frozen_string_literal: true

require 'colorize'

# This section is used to handle most of our messages, and the starting conditions of our game
class GameStart
  attr_reader :choice

  def greetings
    puts ''
    puts '### Welcome to my good-enoughly(?) coded game of "Mastermind"! ###'
    puts '  Would you like to be the CODEMAKER, or the CODEBREAKER?'
    puts '  Send "1" for CODEMAKER, or "2" for CODEBREAKER.'
    puts '  Also, if you want to know the rules, send "3".'
  end

  def game_choice
    @choice = gets.chomp
    case
    when @choice == '1' then puts "  You're the CODEMAKER! Pick your code and good luck!"
    when @choice == '2' then puts "  You're the CODEBREAKER! Good luck! You have 10 tries left."
    when @choice == '3' then tutorial
    else puts '  Please pick a valid option.' && game_choice
    end
  end

  def tutorial
    puts ''
    puts '  Mastermind is a game where the CODEMAKER builds a four-digit code, and the CODEBREAKER '
    puts 'must guess that code. The CODEMAKER will pick digits ranging from 1 to 6 to build their'
    puts "code. For example, '2454' is a valid code, while '9495' isn't."
    puts ''
    puts '  The CODEBREAKER has 10 turns to guess the code. Every time they take a guess, little   '
    puts 'dots will show up telling you how good your guess was.'
    puts ''
    puts '  "x" means you guessed a right digit, but it was in the wrong spot.'
    puts '  "x"'.red << ' means you guessed a right digit in the right spot.'
    puts '  If no dots show up, your guess was completely wrong.'
    puts ''
    puts '  If the CODEBREAKER manages to crack the code, the CODEBREAKER wins. Otherwise, the     '
    puts 'CODEMAKER wins. Now, Send "1" for CODEMAKER, or "2" for CODEBREAKER.'
    puts ''

    game_choice
  end
end

# This section handles all moves made by the computer
class Computer
  attr_reader :mastermind_code

  def build_mastermind_code
    @mastermind_code = []
    @mastermind_code.push(rand(1..6).to_s) until @mastermind_code.length == 4

    puts '  *evil computer noises*'
    puts ''
  end
end

# This section handles all moves made by the player
class Player
  def initialize(mastermind_code)
    @mastermind_code = mastermind_code
  end

  def guessing
    @guess = gets.chomp.to_s.split('')
    valid_digits = %w[1 2 3 4 5 6]
    @guess.each do |element|
      next unless valid_digits.include?(element) == false || @guess.length != 4

      puts '  Invalid code. Please enter a four digit code with values ranging from 1 to 6.'
      guessing
      break
    end
  end

  def code_broken?
    (1..11).each do |i|
      if @guess == @mastermind_code
        puts '  You cracked the code! Great job!'
        break
      elsif i < 10 && @guess != @mastermind_code
        puts "  Not quite. Try again! You have #{10 - i} tries left!"
        getting_tips(@guess, @mastermind_code)
      elsif i == 10 && @guess != @mastermind_code
        puts '  Not quite. Try again! This is your last chance!'
        getting_tips(@guess, @mastermind_code)
      elsif i > 10 && @guess != @mastermind_code
        puts "  You didn't manage to crack the code. It was #{@mastermind_code}. Good luck next time!"
      end
    end
  end

  def getting_tips(guess, code)
    tempguess = guess.dup
    tempcode = code.dup

    (tempguess.length - 1).downto(0) do |i|
      next unless tempguess[i] == tempcode[i]

      tempguess.delete_at(i)
      tempcode.delete_at(i)
      puts 'x'.red
    end

    (tempguess.length - 1).downto(0) do |i|
      next unless tempcode.include?(tempguess[i])

      tempguess.delete_at(i)
      puts 'x'
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

### things to do ###
# 1 - Write the algorithm for the computer to play as the CODEBREAKER
# 3 - Add a condition to replay the game after you finish a match
# 4 - Add comments on every method you've built
