class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def after_sign_out_path(resource_or_scope)
    root_path
  end

  def current_player
    current_user.try(:current_player_in_game, current_game)
  end

  def assign_game
    @game = current_game
  end

  def current_game
    Game.find(params[:id] || params[:game_id])
  end

  def current_round
   current_game.last_player_round
  end

  def reload_partial(partial = "shared/game_table")
    assign_game
    respond_to do |format|
      format.html {
        if request.xhr?
          render :partial => partial
        else
          redirect_to @game
        end
      }
    end
  end
end
