# frozen_string_literal: true

class Interface
  attr_reader :player, :deck, :bank, :diler

  def initialize(player_name)
    @deck = Deck.new
    @bank = Bank.new
    @player = Player.new(player_name)
    @diler = Player.new("Дилер")
    game_start
  end

  def game_start
    puts "\nРаздача карт игрокам: #{player.name} и #{diler.name}"
    2.times do
      player.add_card(deck)
      diler.add_card(deck)
    end

    puts "\nСтартовая ставка 10$"
    player.bid(bank)
    diler.bid(bank)

    info
    player_turn
  end

  def player_turn
    puts "\n\nХод игрока #{player.name}"
    # в начале хода проверка на наличие 3х карт
    puts "\nВведите номер действия:\n1) Пропустить\n2) Добавить карту\n3) Открыть карты"
    user_input = gets.chomp.to_i
    player_turn unless (1..3).include?(user_input)

    case user_input
    when 1
      diler_turn
    when 2
      player.add_card(deck)
      puts "\n#{player.name} берет карту"
      diler_turn
    when 3
      game_end
    end
  end

  def diler_turn
    puts "\n\nХод игрока #{diler.name}"
  end

  def info(game_active: true)
    print "\nВаши карты:"
    show_player_card(player)
    puts "\nКоличество очков: #{player.points}"
    puts "Денег: #{player.money}$"
    print 'Карты дилера:'
    game_active ? show_player_card(diler, hide: true) : show_player_card(diler)
  end

  def show_player_card(player, hide: false)
    player.cards.each { |card| print hide ? ' *' : " #{card.rank}#{card.suit_unicode} " }
  end

  def game_end
    puts "\n___\nРезультат игры:"
    info(game_active: false)
    puts "\nКоличество очков дилера: #{diler.points}"
    winner = result_calculate
    puts winner.nil? ? "\nНичья" : "\nПобедитель #{winner.name}\nВыигрыш: 20$"
  end

  protected

  def result_calculate
    player_score = 21 - player.points
    diler_score = 21 - diler.points
    winner = nil

    if player_score.negative?
      winner = diler
      bank.win_pay(winner)
    elsif player_score == diler_score
      bank.win_pay(player)
      bank.win_pay(diler)
    else
      winner = player_score < diler_score ? player : diler
      bank.win_pay(winner)
    end

    winner
  end
end
