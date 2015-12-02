class CardPassingSet < ActiveRecord::Base

  attr_accessible :player_round_id, :is_ready

  belongs_to :player_round
  has_one :player, :through => :player_round
  has_many :play_cards

  validates_presence_of :player_round

  def is_not_ready?
    !is_ready
  end

end
