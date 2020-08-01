class OenologistsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_oenologist, only: [:show, :edit, :update, :destroy]


  def index
    @oenologists = Oenologist.all
  end

  def show
  end


  def new
    @oenologist = Oenologist.new
    @magazineList = Magazine.order(:id)
    @cargos = ['Editor','Writter','Reviewer']
  end

  def edit
  end

  def create
    @oenologist = Oenologist.new(oenologist_params)
    @oenologist.save
    @oenologist = Oenologist.last
    @cargos = params[:cargos]
    @magazine = params[:magazine_id]
    @cargos.each do |cargo|
      @oenologist_magazine = OenologistMagazine.new()
      @oenologist_magazine.oenologist_id = @oenologist.id
      @oenologist_magazine.magazine_id = @magazine
      @oenologist_magazine.charge = cargo
      @oenologist_magazine.save
    end
    respond_to do |format|
      if @oenologist.save
        format.html { redirect_to @oenologist, notice: 'Oenologist was successfully created.' }
        format.json { render :show, status: :created, location: @oenologist }
      else
        format.html { render :new }
        format.json { render json: @oenologist.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @oenologist.update(oenologist_params)
        format.html { redirect_to @oenologist, notice: 'Oenologist was successfully updated.' }
        format.json { render :show, status: :ok, location: @oenologist }
      else
        format.html { render :edit }
        format.json { render json: @oenologist.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @oenologist.destroy
    respond_to do |format|
      format.html { redirect_to oenologists_url, notice: 'Oenologist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_oenologist
      @oenologist = Oenologist.find(params[:id])
    end

    
    def oenologist_params
      params.require(:oenologist).permit(:name, :age, :nationality)
    end
end
