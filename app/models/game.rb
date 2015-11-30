class Game < ActiveRecord::Base

  attr_accessible :first_winner_id, :second_winner_id, :name1, :name2, :session_id

  has_many :players, :dependent => :destory, :order => "seat ASC"
  has_many :rounds, :dependent => :destory, :order => "position ASC"
  belong_to :winner, :class_name => "Player"

  delegate :card_passing_sets, :to => :last_round
  delegate :cards_have_been_passed, :to => :last_round

  def add_player_from_user_list(user)
    if can_accomodate(user)
      Player.create({:user => user, :game => self, :seat => next_seat})
    end
  end

  def play_cards(cards)
    last_cards_play.play_cards_from(next_player, cards)
  end

  def create_round
    round = Round.create({:game => self, :dealer_id => get_new_dealer.id, :position => next_round_position})
  end

  def next_seat
    self.players(true).length
  end

  def next_round_position
    rounds_played
  end

  def is_table_full?
    players(true).length >= 4
  end

  def is_over?
    first_winner_id.present?
  end

  def is_not_over?
    !is_over?
  end

  def player_seated_at(seat)
    self.players.where("seat = ?", seat).first
  end

  def already_has(user)
    present_usernames.includes?(user.username)
  end

  def is_current_player_turn?(current_player)
    last_played.try(:is_not_over?) && current_player == next_player
  end

  def next_player
    last_played.try(:next_player)
  end

  def last_played
    last_round.try(:last_played)
  end

  def cards_playeds
    last_played.try(:cards_playeds)
  end

  def previous_played
    last_round.try(:previous_played)
  end

  def is_ready_for_new_round?
    is_table_full? && new_round_time? && is_not_over?
  end

  def passing_time?
    last_round.try(:passing_time?) || false
  end

  def ready_to_pass?
    passing_time? && passing_sets_are_ready?
  end

  def rounds_played
    rounds(true).length
  end

  def present_usernames
    players.map(&:username)
  end

  def empty_seats
    4 - players.length
  end
end
