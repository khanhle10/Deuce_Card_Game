class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :conversations, :foreign_key => :sender_id
  has_one :lobby, :foreign_key => :game_id
  belongs_to :lobby
  after_create :create_default_conversation

end
