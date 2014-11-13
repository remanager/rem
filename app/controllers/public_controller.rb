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
    @properties = @realestate.search(rest_params)

    return render :show, notice: 'No property have been found.' unless @properties
    return redirect_to property_path(@realestate, @properties) if @properties.class == Property
    render :show
  end

  def search_dirty
    @realestate = Realestate.find(params[:realestate_id])
    redirect_to search_path(rest_params)
  end

  private

  def rest_params
    [:ref, :town_id, :category_ids, :detail_ids].inject(realestate_id: @realestate.id) do |hash, key|
      hash[key] = params[key] if params[key].present?
      hash
    end
  end
end
