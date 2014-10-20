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
    # @realestate = Realestate.find(params[:realestate_id])
    @property = Property.find(params[:id])
    render_404 unless @property
  end
end
