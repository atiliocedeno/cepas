class CepasController < ApplicationController
  before_action :authorize_admin!
  before_action :set_cepa, only: [:show, :edit, :update, :destroy]

  def index
    @cepas = Cepa.all
  end

 
  def show
  end


  def new
    @cepa = Cepa.new
  end

  def edit
  end

  def create
    @cepa = Cepa.new(cepa_params)

    respond_to do |format|
      if @cepa.save
        format.html { redirect_to @cepa, notice: 'Cepa was successfully created.' }
        format.json { render :show, status: :created, location: @cepa }
      else
        format.html { render :new }
        format.json { render json: @cepa.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @cepa.update(cepa_params)
        format.html { redirect_to @cepa, notice: 'Cepa was successfully updated.' }
        format.json { render :show, status: :ok, location: @cepa }
      else
        format.html { render :edit }
        format.json { render json: @cepa.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @cepa.destroy
    respond_to do |format|
      format.html { redirect_to cepas_url, notice: 'Cepa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_cepa
      @cepa = Cepa.find(params[:id])
    end

    def cepa_params
      params.require(:cepa).permit(:name)
    end

    def record_not_unique 
      flash[:alert] = "There is another cepa with that name"
      redirect_to "/cepas/new"
    end
end
