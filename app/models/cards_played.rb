class CardsPlayed < ActiveRecord::Base
  attr_accessible :player_card_id
  attr_accessible :player_id
  attr_accessible :position

  belongs_to :player_cards
  has_one :player, :through => :player_cards
  has_one :cards, :through => :player_cards
  belongs_to :cards_played

  validates_presence_of :player_card_id
  validates_presence_of :cards_played_id
  validates_presence_of :position

  delegate :suit, :value, :beat_previous_play?, :value_weight, :to => :cards
  # check for current player seat
  def get_position(current_player)
    current_player.nil? ? player.seat : (player.seat - current_player.seat) % 4
  end
end
