# frozen_string_literal: true

require_relative 'validation'
require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'bank'
require_relative 'interface'

def start
  print "\nДобро пожаловать в игру БлэкДжек!\n\nВведите ваше имя: "
  user_input = gets.chomp.capitalize

  player = Player.new(user_input)
  Interface.new(player).game_start
rescue RuntimeError => e
  puts "\nОшибка: #{e.message}"
  start
end

system 'clear'
start
