# frozen_string_literal: true

class Player
  attr_reader :name, :cards, :points
  attr_accessor :money

  def initialize(name)
    self.name = name
    self.money = 100
    self.points = 0
  end

  def add_card(deck)
    self.cards ||= []
    cards << deck.give_card
    points_update(cards.last)
  end

  def bid(bank)
    self.money -= 10
    # Валидация
    bank.money += 10
  end

  def cards_count
    cards.length
  end

  def cards_drop
    self.cards = []
    self.points = 0
  end

  protected

  attr_writer :name, :cards, :points

  def points_update(card)
    self.points += if card.rank == 'Ace'
                     (points + card.card_points) > 21 ? 1 : card.card_points
                   else
                     card.card_points
                   end
  end
end
