# frozen_string_literal: true

class Player
  attr_reader :name, :cards, :bank, :points

  def initialize(name)
    self.name = name
    self.bank = 100
    self.points = 0
  end

  def add_card(deck)
    self.cards ||= []
    cards << deck.give_card
    points_update(cards.last)
  end

  def points_update(card)
    self.points += if card.rank == 'Ace'
                     (points + card.card_points) > 21 ? 1 : card.card_points
                   else
                     card.card_points
                   end
  end

  protected

  attr_writter :name, :cards, :bank, :points

  def name_validate!; end
end
