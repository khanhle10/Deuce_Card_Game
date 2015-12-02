class PlayerRound < ActiveRecord::Base
  attr_accessible :player_id
  attr_accessible :round_id
  attr_accessible :round_winners

  belong_to :player
  belong_to :round
  has_one :cards_passing_set

  validates_presence_of :player_id
  validates_presence_of :round_id
  validates_presence_of :round_winners

  delegate :to => :round

end
