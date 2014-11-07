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

  def search
    @realestate = Realestate.find(params[:realestate_id])
    property_params = params.require(:property).permit(:ref, :town_id, :category_ids, :detail_ids)
    @properties = @realestate.search(property_params)

    return redirect_to @realestate, notice: 'No property have been found.' unless @properties
    return redirect_to property_path(@realestate, @properties.first) if @properties.size == 1
    redirect_to realestate_path(@realestate)
  end
end
