class PlayerCard < ActiveRecord::Base
  SUIT_WEIGHT = Card::SUIT_WEIGHT
  VALUE_WEIGHT = Card::VALUE_WEIGHT

  attr_accessible :player_id
  attr_accessible :card_id
  attr_accessible :card_passing_set_id

  belongs_to :player
  belongs_to :card
  has_one :cards_played, :dependent => :destory

  validates_presence_of :player_id
  validates_presence_of :card_id

  delegate :suit, :value, :suit_weight, :value_weight, :to => :card
  delegate :last_place, :to => :player
  
end
