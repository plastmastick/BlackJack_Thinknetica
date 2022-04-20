# frozen_string_literal: true

class Interface
  AI_MAX_POINTS = 17
  MAX_CARDS = 3
  WIN_POINT = 21

  def initialize(player)
    @deck = Deck.new
    @bank = Bank.new
    @player ||= player
    @diler ||= Player.new('Дилер')
  end

  def game_start
    @deck.create_deck

    puts "\nРаздача карт игрокам: #{@player.name} и Дилер"
    2.times do
      @player.add_card(@deck)
      @diler.add_card(@deck)
    end

    puts "\nСтартовая ставка 10$"
    start_bid

    player_turn
  end

  def player_turn
    check_players_cards_count

    puts "\nХод игрока #{@player.name}"
    info
    puts "\n\nВведите номер действия:\n1) Пропустить\n2) Добавить карту\n3) Открыть карты"
    user_input = gets.chomp.to_i

    case user_input
    when 1
      diler_turn
    when 2
      @player.add_card(@deck)
      diler_turn
    when 3
      game_end
    else
      player_turn
    end
  end

  def diler_turn
    check_players_cards_count

    if @diler.points < AI_MAX_POINTS && @diler.cards.length < MAX_CARDS
      @diler.add_card(@deck)
      console_clear 'Ход игрока Дилер - Игрок берет карту'
    else
      console_clear 'Ход игрока Дилер - Игрок пропускает ход'
    end

    player_turn
  end

  def game_end
    console_clear
    puts 'Результат игры:'
    info(game_active: false)
    puts "\nКоличество очков дилера: #{@diler.points}"

    winner = result_calculate
    puts winner.nil? ? "\nНичья" : "\nПобедитель #{winner.name}\nВыигрыш: 20$"

    puts "\n\nКонец игры"
    restart_interface
  end

  def restart_interface
    puts "\nСыграть ещё раз?(1 - Сыграть, 0 - Выход)"
    user_input = gets.chomp.to_i
    console_clear
    return if user_input.zero?

    restart_interface if user_input != 1
    @player.cards_drop
    @diler.cards_drop
    game_start
  end

  def info(game_active: true)
    print "\nВаши карты:"
    show_player_card(@player)

    puts "\nКоличество очков: #{@player.points}"
    puts "Денег: #{@player.money}$"

    print 'Карты дилера:'
    game_active ? show_player_card(@diler, hide: true) : show_player_card(@diler)
  end

  def show_player_card(player, hide: false)
    player.cards.each { |card| print hide ? ' *' : " #{card.rank}#{card.suit_unicode} " }
  end

  protected

  def check_players_cards_count
    game_end if @player.cards_count == MAX_CARDS && @diler.cards_count == MAX_CARDS
  end

  def result_calculate
    player_score = @player.points
    diler_score = @diler.points

    winner = if diler_win?(player_score, diler_score)
               @diler
             elsif player_win?(player_score, diler_score)
               @player
             end

    winner.nil? ? @bank.draw_pay(@player, @diler) : @bank.win_pay(winner)
    winner
  end

  def start_bid
    @player.bid(@bank)
    @diler.bid(@bank)
  end

  def console_clear(message = '')
    system 'clear'
    puts message
  end

  def diler_win?(player_score, diler_score)
    (WIN_POINT - player_score).negative? || (player_score < diler_score && !(WIN_POINT - diler_score).negative?)
  end

  def player_win?(player_score, diler_score)
    player_score > diler_score || (WIN_POINT - diler_score).negative?
  end
end
