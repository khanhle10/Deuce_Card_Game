class CardsPlayedController < ApplicationController
  before_filter :assign_game

  def create
    cards = Player_cards.find(params[:cards].to_i) if params[:cards]
    @game.player_cards(cards)
    reload_partial
  end
end
