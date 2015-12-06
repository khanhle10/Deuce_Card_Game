class TestNamesController < ApplicationController
  before_action :set_test_name, only: [:show, :edit, :update, :destroy]

  # GET /test_names
  # GET /test_names.json
  def index
    @test_names = TestName.all
  end

  # GET /test_names/1
  # GET /test_names/1.json
  def show
  end

  # GET /test_names/new
  def new
    @test_name = TestName.new
  end

  # GET /test_names/1/edit
  def edit
  end

  # POST /test_names
  # POST /test_names.json
  def create
    @test_name = TestName.new(test_name_params)

    respond_to do |format|
      if @test_name.save
        format.html { redirect_to @test_name, notice: 'Test name was successfully created.' }
        format.json { render :show, status: :created, location: @test_name }
      else
        format.html { render :new }
        format.json { render json: @test_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_names/1
  # PATCH/PUT /test_names/1.json
  def update
    respond_to do |format|
      if @test_name.update(test_name_params)
        format.html { redirect_to @test_name, notice: 'Test name was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_name }
      else
        format.html { render :edit }
        format.json { render json: @test_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_names/1
  # DELETE /test_names/1.json
  def destroy
    @test_name.destroy
    respond_to do |format|
      format.html { redirect_to test_names_url, notice: 'Test name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_name
      @test_name = TestName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_name_params
      params.require(:test_name).permit(:name)
    end
end
