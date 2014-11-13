class PublicController < ApplicationController
  before_filter :set_realestate, except: :index

  def index
    @realestates = Realestate.all
    render_404 unless @realestates
  end

  def show
    @properties = @realestate.properties.includes(:details, :categories)
  end

  def property
    @property = @realestate.properties.find(params[:id])
  end

  def categories_index
    @categories = @realestate.categories
  end

  def categories_show
    @category = @realestate.categories.find(params[:id])
    @properties = @category.properties.where(realestate: @realestate)
  end

  def search
    @properties = @realestate.search(rest_params)

    return render :show, notice: 'No property have been found.' unless @properties
    return redirect_to property_path(@realestate, @properties) if @properties.class == Property
    render :show
  end

  def search_dirty
    redirect_to search_path(rest_params)
  end

  private

  def set_realestate
    @realestate = Realestate.find(params[:realestate_id])
  end

  def rest_params
    [:ref, :town_id, :category_ids, :detail_ids].inject(realestate_id: @realestate.id) do |hash, key|
      hash[key] = params[key] if params[key].present?
      hash
    end
  end
end
