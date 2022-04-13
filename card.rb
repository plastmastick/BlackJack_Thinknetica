# frozen_string_literal: true

class Card
  attr_reader :rank, :suit, :points

  RANKS = { 1 => 'Ace', 11 => 'Jack', 12 => 'Queen', 13 => 'King' }.freeze
  SUITS = { 1 => 'clubs', 2 => 'diamonds', 3 => 'hearts', 4 => 'spades' }.freeze
  SUITS_U = { clubs: "\u{2663}", diamonds: "\u{2666}", hearts: "\u{2665}", spades: "\u{2660}" }.freeze

  def initialize(rank, suit)
    rank_name(rank)
    suit_name(suit)
  end

  def card_points
    self.points = if %w[Jack Queen King].include?(rank)
                    10
                  elsif rank == 'Ace'
                    11
                  else
                    rank.to_i
                  end
  end

  def suit_unicode
    SUITS_U[suit.to_sym]
  end

  private

  attr_writer :points

  def rank_name(value)
    @rank = RANKS[value] || value.to_s
  end

  def suit_name(value)
    @suit = SUITS[value]
  end
end
