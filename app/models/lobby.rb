class Lobby < ActiveRecord::Base
  has_many :game_id
  has_many :users
end
