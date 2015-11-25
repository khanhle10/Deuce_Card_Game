class Card < ActiveRecord::Base
  VALUE_WEIGHT = Hash[%w(3 4 5 6 7 8 9 10 J Q K A 2).zip((1..13).to_a)]
  SUIT_WEIGHT = Hash[%w(spade club diamond heart).zip((0..3).to_a)]

  attr_accessible :suit, :value

  has_many :player_cards, :dependent => :destory

  validates_presence_of :suit

  
end
