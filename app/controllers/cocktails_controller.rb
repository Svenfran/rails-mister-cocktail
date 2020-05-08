class CocktailsController < ApplicationController
  before_action :set_cocktail, only: :show

  def index
    @cocktails = Cocktail.all
  end

  def show
  end
  
  def new
    @cocktail = Cocktail.new
  end
  
  def create
    @cocktail = Cocktail.new(cocktail_params)
  end
  
  private

  def cocktail_params
    params.require(:cocktail).permit(:id)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
  
  
end
