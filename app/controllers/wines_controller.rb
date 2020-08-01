class WinesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authorize_admin!, only:[:new, :edit,:update, :destroy]
  before_action :set_wine, only: [:show, :edit, :update, :destroy]


  def index
    @wines = Wine.all
  end

  def show
  end

  
  def new
    @operacion = 'New'
    @wine = Wine.new
    @cepaList = Cepa.order(:id)
    @enologos = Oenologist.all
  end

  # GET /wines/1/edit
  def edit
    @operacion = 'Edit'
    @enologos = Oenologist.all
    @evaluation = Evaluation.where(wine_id: params["id"])
    @cepaList = WineCepa.where(wine_id:  params["id"])
  end


  def create

    @wine.save
    @wine = Wine.last
    @cepas = Cepa.all
    @enologos = params["enologos"]
    @cepas.each do |cepa|
      @wine_cepa = WineCepa.new()
      @porcentaje = params[cepa.name]
      if @porcentaje.to_i > 0 
        @wine_cepa.wine_id = @wine.id
        @wine_cepa.cepa_id = cepa.id
        @wine_cepa.percentage = @porcentaje.to_i
        @wine_cepa.save
      end
    end
    if !@enologos.nil?
      @enologos.each do |enologo|
        @evaluation = Evaluation.new()
        @rank = params[enologo]
        @evaluation.wine_id = @wine.id
        @evaluation.oenologist_id = Oenologist.find_by(name: enologo).id
        @evaluation.rank = @rank
        @evaluation.save
      end
    end
    respond_to do |format|
      if @wine.save
        format.html { redirect_to @wine, notice: 'Wine was successfully created.' }
        format.json { render :show, status: :created, location: @wine }
      else
        format.html { render :new }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @wine_id = params["id"]
    @cepas = WineCepa.where(wine_id:  params["id"])
    @enologos = params["enologos"]
    @cepas.each do |cepa|
      @cepa_params = cepa.cepa.name
      @porcentaje = params[@cepa_params]
      if @porcentaje.to_i > 0 
       
        wineCepa = WineCepa.find_by(wine_id: @wine_id, cepa_id: cepa.cepa_id)
        wineCepa.update(percentage: @porcentaje.to_i)
      else
        WineCepa.find_by(wine_id: @wine_id, cepa_id: cepa.cepa_id).destroy
      end
    end
    @enologos.each do |enologo|
      @rank = params[enologo]
      @evaluation_oenologist_id = Oenologist.find_by(name: enologo).id
      @evaluation_wine_id = @wine.id
      @evaluation = Evaluation.find_by(oenologist_id: @evaluation_oenologist_id, wine_id: @evaluation_wine_id)
      if @evaluation.nil?
        @evaluation = Evaluation.new()
        @evaluation.wine_id = @evaluation_wine_id
        @evaluation.oenologist_id = @evaluation_oenologist_id
        @evaluation.rank = @rank
        @evaluation.save
      else
        @evaluation.update(rank: @rank)
      end
    end
    respond_to do |format|
      if @wine.update(wine_params)
        format.html { redirect_to @wine, notice: 'Wine was successfully updated.' }
        format.json { render :show, status: :ok, location: @wine }
      else
        format.html { render :edit }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @wine.destroy
    respond_to do |format|
      format.html { redirect_to wines_url, notice: 'Wine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_wine
      @wine = Wine.find(params[:id])
    end


    def wine_params
      params.require(:wine).permit(:name)    
    end

    def record_not_unique 
      flash[:alert] = "There is another wine with that name"
      redirect_to "/wines/new"
    end
end
