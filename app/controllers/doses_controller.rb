class DosesController < ApplicationController
  before_action :set_cocktail, except: :destroy
  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end
  
  private
  
  def dose_params
    params.require(:dose).permit(:description, :cocktail_id, :ingredient_id)
  end
  
  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

end
