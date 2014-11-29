class PublicController < ApplicationController
  before_filter :set_realestate, except: [:index, :create_agent]

  def index
    @user = User.new
  end

  def create_agent
    @user = User.new(user_params)
    @user.role = :agent

    if @user.save
      flash.now[:notice] = "You will receive an email on #{ @user.email } when you've got accepted"
      @user = User.new
    else
      flash.now[:alert] = 'Some errors happened.'
    end
    render :index
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
    @title = "Properties on #{ @category.name }"

    render :show
  end

  def search
    @properties = @realestate.search(rest_params)

    return render :show, notice: 'No property have been found.' unless @properties
    return redirect_to property_path(@realestate, @properties) if @properties.is_a? Property
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

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :address)
  end
end
