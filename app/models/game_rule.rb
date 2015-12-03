class GameRule < ActiveRecord::Base
  attr_accessible :round_id
  attr_accessible :start_id
  attr_accessible :position
  attr_accessible :start_suit

  after_create :start_with_three_of_spade?, :if => :start_first?

  belongs_to :round
  belongs_to :winner_id, :class_name => "Player"
  has_many :cards_played, dependent: :destroy,-> {order: "position ASC"}

  validates_presence_of :round_id
  validates_presence_of :winner_id
  validates_presence_of :position

  delegate :players, :player_seated_at, :to => :round

  def play_cards_from(player, card = nil)
    card ||= player.choose_cards(pick_suit, start_first?)
    card_position = next_position
    PlayedCard.create(:player_card_id => card.id, :rule_id => self.id, :position => card_position)
       unless has_card_from?(player) self.update_attributes(:pick_suit => card.suit) if player == winner_id
    round.lost_challenge = true if card.is_less_than_challenge?
    round.save
  end

  def next_player
    player_seated_at((winner_id.seat + next_position) % 4)
  end

  def challenge_winner
    winning_cards.player
  end

  def cards_played_round
    self.cards_played.length
  end

  def is_round_over?
    cards_played_round == 3
  end

  def is_round_not_over?
    cards_played_round < 3
  end

  def display_game_rule_info
    if is_round_over?
      "#{winner_id.username} won the challeng"
    else
      "#{winner_id.username} won the challeng, it is #{next_player.username}'s turn to challenge"
    end
  end

  def next_position
    self.cards_played(true).length
  end

  def winning_cards
    better_cards = cards_played.first
    cards_played.each do |card_play|
      better_cards = card_play if card_play.beat_previous_play?(better_cards)
    end
    better_cards
  end
  private
  def order_of_plays
    in_order = []
    4.times do |i|
      in_order << player_seated_at((start_id.seat + i) % 4)
    end
    in_order
  end
  # start_player
  def start_first?
  end

  def start_with_three_of_spade
    play_cards_from(start_id, start_id.three_of_spade)
  end

  def has_card_from?(player)
    cards_played.each do |card_play|
      return true if card_play == player
    end
    false
  end
end
