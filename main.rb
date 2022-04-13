# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'bank'
require_relative 'interface'

system 'clear'
print "Добро пожаловать в игру БлэкДжек!\n\nВведите ваше имя: "
user_input = gets.chomp.capitalize

Interface.new(user_input)
