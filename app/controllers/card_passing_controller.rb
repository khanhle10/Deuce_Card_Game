class CardPassingController < ApplicationController
  before_filter :assign_game

  def create
    current_round.pass_cards
    reload_partial
  end

  def toggle_passing_status
    player_choice = PlayerCard.find(params[:card].to_i)
    player_choice.toggle_passing_status
    reload_partial("shared/my_selected_cards")
  end

  def passing_sets_are_ready
    current_player.card_passing_set.update_attributes(:is_ready => true)
    reload_partial
  end
  
end
