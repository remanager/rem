class PublicController < ApplicationController
  def index
    @realestates = Realestate.all
    render_404 unless @realestates
  end

  def show
    @realestate = Realestate.find(params[:id])
    render_404 unless @realestate

    @properties = @realestate.properties.includes(:details, :categories)
  end

  def property
    @realestate = Realestate.find(params[:realestate_id])
    @property = Property.find(params[:id])
    render_404 unless @property
  end

  def category
    @realestate = Realestate.find(params[:realestate_id])
    @category = Category.find(params[:id])
    @properties = @category.properties

    redirect_to @realestate, notice: 'The category doesn\'t exist.' unless @category
  end
end
