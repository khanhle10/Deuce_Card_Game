class GameRulesController < ApplicationController
  before_filter :assign_game

  def create
    current_round.create_game_rules
    reload_partial
  end
end
