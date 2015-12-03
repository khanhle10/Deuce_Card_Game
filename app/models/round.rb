class Round < ActiveRecord::Base
  attr_accessible :game_id
  attr_accessible :dealer_id
  attr_accessible :position
  attr_accessible :cards_have_been_passed

  PASS_CARDS_SHIFT = {:seat_0 = 0,:seat_1 = 1, :seat_2 = 2, :seat_3 = 3}
  after_create :create_player_rounds
  after_create :overide_card_passing_on_none_round

  after_create :deal_cards
  after_create :fill_table

  belongs_to :game
  belongs_to :dealer, :class_name => "Player"

  has_many :player_rounds
  has_many :tricks, :dependent => :through => :player_rounds
  has_many :card_passing_sets, :through => :player_rounds

  validates_presence_of :game_id
  validates_presence_of :dealer_id
  validates_presence_of :position

  delegate :player, :player_seated_at, :to => :game
  delegate :leader, :to => :last_played

  def deal_cards
    new_deck = Cards.all
    13.times do
      4.times do |i|
        player = player_seated_at(i)
        random_card = new_deck[rand(new_deck.length)]
        PlayerCards.create(:player_id => player.id, :card_id => random_card.id)
        new_deck.delete(random_card)
      end
    end
  end

  def pass_cards(direction = pass_direction)
    self.update_attributes(:cards_have_been_passed => true)
    return if direction ==  :seat_3
    given_shift = PASS_CARDS_SHIFT[direction]
    card_passing_sets.each do |set|
      set.player_cards.each do |player_cards|
        new_seat = (player_cards.player.seat + given_shift) %4
        player_cards.update_attributes(:player_id => player_seated_at(new_seat).id)
      end
    end
  end

  def passing_cards_direction(round_number = position)
    [:seat_0, :seat_1, :seat_2, :seat_3][round_number % 4]
  end

  def cards_passing_sets
    player_rounds.map(&:cards_passing_set)
  end

  def has_started?
    !has_not_started_yet?
  end

  def has_not_started_yet?
    !cards_have_been_passed
  end
end
