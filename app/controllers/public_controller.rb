class PublicController < ApplicationController
  def index
    @realestates = Realestate.all
    render_404 unless @realestates
  end
end
