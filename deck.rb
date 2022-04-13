# frozen_string_literal: true

class Deck
  attr_reader :deck

  def initialize
    @deck = []
    create_deck
  end

  def create_deck
    rank_num = 1
    suit_num = 1
    13.times do
      4.times do
        @deck << Card.new(rank_num, suit_num)
        suit_num += 1
      end
      suit_num = 1
      rank_num += 1
    end
  end

  def give_card
    random_card = deck[rand(deck.length)]
    deck.delete(random_card)
    random_card
  end
end
