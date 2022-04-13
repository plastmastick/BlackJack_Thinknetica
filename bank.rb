# frozen_string_literal: true

class Bank
  include Validation

  attr_accessor :money

  def initialize
    @money = 0
  end

  def win_pay(player)
    validate! :money, { zero: nil }
    player.money += money
    self.money = 0
  end

  def draw_pay(*players)
    validate! :money, { comparison_min: 20 }
    players.each do |player|
      player.money += 10
      self.money -= 10
    end
  end
end
