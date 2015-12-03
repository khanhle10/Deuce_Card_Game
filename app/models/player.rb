class Player < ActiveRecord::Base
  attr_accessible :game_id
  attr_accessible :user_id
  attr_accessible :seat
  attr_accessible :position

  belongs_to :game
  belongs_to :user
  has_many :player_cards
  has_many :cards, :through => :player_cards
  has_many :cards_played, :through => :player_cards
  has_many :player_rounds,-> {order: "create_at Round"}

  validates_presence_of :game_id
  validates_presence_of :seat
  validates_presence_of :position

  delegate :cards_passing_set, :to => :last_player_round
  delegate :first_winner, :to => :last_player_round
  delegate :second_winner, :to => :last_player_round
  delegate :last_place, :to => :last_player_round

  def username
    user.try(:username)
  end

  def hand
    cards_in_hand = self.reload.player_cards(true).joins("LEFT JOIN cards_played ON cards_played.player_card_id = cards_played.id")
    .where("played_cards.id IS NULL").readonly(false)
        collection.sort{|a,b| a.hand_order <=> b.hand_order }
  end

  def choose_cards(pick_suit, is_first_play)
    choose = pick_suit.nil? hand.shuffle : hand
    choose.each { |c| return c if c.is_valid?(pick_suit, is_first_play)}
  end

  def has_none_of(suit)
    self.hand.each do |c|
      return false if c.suit == suit
    end
    true
  end

  def only_has?(suit)
    self.hand.each do |c|
      return false if c.suit != suit
    end
    true
  end

  def round_position
    last_player_round.try(:round_position) || 0
  end

  def last_player_round
    player_rounds.last
  end

  def is_first_place?
    self == first_winner
  end

  def cards_to_pass
    card_passing_set.player_cards
  end

  def ready_to_pass?
    cards_to_pass.length == 3 && !card_passing_set.is_ready?
  end

  def has_passed?
    card_passing_set.is_ready
  end

  def has_not_passed_yet?
    !has_passed
  end

  def relative_seat_of(player)
    seat_shift = (player.seat - self.seat) % 4
    %w(seat_0 seat_1 seat_2 seat_3)[seat_shift]
  end

  def seat_position
    %w(seat_0 seat_1 seat_2 seat_3)[seat]
  end
end
