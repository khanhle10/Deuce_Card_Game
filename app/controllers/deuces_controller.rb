class DeucesController < ApplicationController
  @@PLAYER_JOINED = "playerJoined"
  @@ROOM_CREATED = "roomCreated"
  @@PUBLIC_CHANNEL = 'publicChannel'
  before_action :set_deuce, only: [:show, :edit, :update, :destroy]

  # GET /deuces
  # GET /deuces.json
  def index
    @deuces = Deuce.where("? < player_count AND player_count < ?", 0, 4)
  end

  def join
    @deuce = Deuce.find(params[:id])

    user_count = 1

    if @deuce[:player2].nil?
      @deuce[:player2] = current_user[:id]
      user_count += 1
    elsif @deuce[:player3].nil?
      @deuce[:player3] = current_user[:id]
      user_count += 1
    elsif @deuce[:player4].nil?
      @deuce[:player4] = current_user[:id]
      user_count += 1
    end

    @deuce[:player_count] = user_count

    respond_to do |format|
      if @deuce.save

        Pusher.trigger("deuce_#{@deuce[:id]}", @@PLAYER_JOINED, {})

        format.html { redirect_to @deuce, notice: 'Successfully joined the game.' }
        format.json { render :Show, status: :ok, location: @deuce }
      else
        render nothing: true
      end
    end
  end
  # GET /deuces/1
  # GET /deuces/1.json
  def show
  end

  # GET /deuces/new
  def new
    @deuce = Deuce.new
  end

  # GET /deuces/1/edit
  def edit
  end

  # POST /deuces
  # POST /deuces.json
  def create
    data = {:name => params[:roomName], :player1 => current_user[:id], :player_count => 1}

    @deuce = Deuce.new(data)

    @deuce.save

    Pusher.trigger(@@PUBLIC_CHANNEL, @@ROOM_CREATED, {})

    redirect_to @deuce
  end

  # PATCH/PUT /deuces/1
  # PATCH/PUT /deuces/1.json
  def update
    respond_to do |format|
      if @deuce.update(deuce_params)
        format.html { redirect_to @deuce, notice: 'Deuce was successfully updated.' }
        format.json { render :show, status: :ok, location: @deuce }
      else
        format.html { render :edit }
        format.json { render json: @deuce.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deuces/1
  # DELETE /deuces/1.json
  def destroy
    @deuce.destroy
    respond_to do |format|
      format.html { redirect_to deuces_url, notice: 'Deuce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deuce
      @deuce = Deuce.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deuce_params
      params.require(:deuce).permit(:player_count, :name, :player1, :player2, :player3, :player4)
    end
end
