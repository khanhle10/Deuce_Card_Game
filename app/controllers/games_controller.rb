class GamesController < ApplicationController
  before_filter :store_location, :only => [:index, :show]
  before_filter :require_user, :only => :show
  before_filter :assign_game, :only => [:show, :destory]

  def game
    @game = Game.all
  end

  def new
    @game = Game.new
  end
  def show
    api_key = ""
    api_secret = ""
    @openTok = OpenTok::OpenTokSDK.new api_key, api_secret if @openTok.nil?
    @token = @openTok.generate_token(:session_id => @game.session_id)
    @game = Game.find(params[:id])

    @game.add_player_from_user(current_user)
    respond_to do |format|
      format.html
       format.json do render :json => {
         :shouldStartNewRound => @game.is_ready_for_new_round?,
         :shouldPassCards => @game.is_ready_to_pass?,
         :isStartingFirstRound => @game.rounds.empty?,
         :shouldReloadWaitAutoPlay => @game.should_reload?(current_player),
         :shouldReloadAndJustWait => @game.should_reload_and_wait?(current_player)
        }
     end
    end
  end

  def create
    @game = Game.new(params[:game])
    api_key = ""
    api_secret = ""
    @openTok = OpenTok::OpenTokSDK.new api_key, api_secret
    session = @openTok.create_session request.remote_addr
    @game.update_attributes(:session_id => session.session_id)
    name = game[:name] # input from html
    @game[:name] = name # setting input into db object (model)

    if @game.save
      redirect_to @game, alert: "game created"
    else
      render action: 'new'
    end
  end
  
  def destory
    @game.destory
    redirect_to games_url
  end

  def reload
    reload_partial
  end
end
