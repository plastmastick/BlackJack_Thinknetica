# frozen_string_literal: true

class Bank
  include Validation

  attr_accessor :money

  STEP = 10
  STEP_COUNT_PER_GAME = 1

  def initialize
    @money = 0
  end

  def win_pay(player)
    validate! :money, { zero: nil }
    player.money += money
    @money = 0
  end

  def draw_pay(*players)
    one_pay_size = STEP * STEP_COUNT_PER_GAME
    total_pay_size = players.length * one_pay_size
    validate! :money, { comparison_min: total_pay_size }

    players.each do |player|
      player.money += one_pay_size
      @money -= one_pay_size
    end
  end
end
