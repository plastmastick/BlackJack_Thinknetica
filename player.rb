# frozen_string_literal: true

class Player
  include Validation

  attr_reader :name, :cards, :points
  attr_accessor :money

  STEP = 10
  WIN_POINT = 21

  def initialize(name)
    @name = name
    @money = 100
    @points = 0
    validate!(:name, { presence: nil, comparison_min_length: 2 })
  end

  def add_card(deck)
    @cards ||= []
    cards << deck.give_card
    points_update(cards.last)
  end

  def bid(bank)
    validate! :money, { presence: nil, comparison_min: STEP }
    @money -= STEP
    bank.money += STEP
  end

  def cards_count
    @cards.length
  end

  def cards_drop
    @cards = []
    @points = 0
  end

  protected

  attr_writer :cards

  def points_update(card)
    @points += if card.rank == 'Ace'
                 (points + card.card_points) > WIN_POINT ? 1 : card.card_points
               else
                 card.card_points
               end
  end
end
