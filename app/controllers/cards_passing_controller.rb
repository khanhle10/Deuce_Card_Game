class CardsPassingController < ApplicationController
  before_filter :assign_game

  def create
    current_game.pass_cards
    reload_partial
  end

  def passing_set_ready
    current_player.card_passing_set.update_attributes(:is_ready => true)
  end

end
