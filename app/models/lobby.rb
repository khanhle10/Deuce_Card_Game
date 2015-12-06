class Lobby < ActiveRecord::Base
  has_many :game_id, :user_name, :game_score
end
