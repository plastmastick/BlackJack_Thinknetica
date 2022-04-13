# frozen_string_literal: true

class Bank
  attr_accessor :money

  def initialize
    @money = 0
  end

  def win_pay(player)
    player.money += money
    self.money = 0
  end

  def draw_pay(*players)
    players.each do |player|
      player.money += 10
      self.money -= 10
    end
  end
end
