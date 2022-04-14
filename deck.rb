# frozen_string_literal: true

class Deck
  attr_reader :deck

  RANKS_COUNT = 13
  SUITS_COUNT = 4

  def initialize
    @deck = []
  end

  def create_deck
    @deck = [] unless @deck.empty?
    rank_num = 1
    RANKS_COUNT.times do
      suit_num = 1
      SUITS_COUNT.times do
        @deck << Card.new(rank_num, suit_num)
        suit_num += 1
      end
      rank_num += 1
    end
  end

  def give_card
    random_card = deck[rand(deck.length)]
    deck.delete(random_card)
    random_card
  end
end
