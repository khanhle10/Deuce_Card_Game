class Card < ActiveRecord::Base
  VALUE_WEIGHT = Hash[%w(3 4 5 6 7 8 9 10 J Q K A 2).zip((1..13).to_a)]
  SUIT_WEIGHT = Hash[%w(spade club diamond heart).zip((0..3).to_a)]

  attr_accessible :suit, :value

  has_many :player_cards, :dependent => :destroy

  validates_presence_of :suit
  validates_presence_of :value

  def beat_previous_play?
    suit == current_cards_played.suit && value_weight > current_cards_played.value_weight
  end

  def value_weight
    VALUE_WEIGHT[value]
  end

  def suit_weight
    SUIT_WEIGHT[suit]
  end

  def is_a_heart
    suit == "heart"
  end

  def is_a_spade
    suit = "spade"
  end

  def is_a_club
    suit = "club"
  end

  def is_a_diamond
    suit = "diamond"
  end

end
