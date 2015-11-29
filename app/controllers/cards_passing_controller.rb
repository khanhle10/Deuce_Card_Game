class CardsPassingController < ApplicationController
  before_filter :assign_game

  def create
    current_game.pass_cards
    reload_partial
  end

  def passing_set_ready
    current_player.card_passing_set.update_attributes(:is_ready => true)
  end

  def toggle_passing_status
    player_choice = PlayCard.find(params[:card].to_i)
    player_choice.toggle_passing_status
    reload_partial("shared/my_selected_cards")
  end

  def passing_set_ready
    current_player.card_passing_set.update_attributes(:is_ready => true)
    reload_partial("shared/nothing")
  end
end
