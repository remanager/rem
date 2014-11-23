class Admin::PropertiesController < AdminController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = current_user.my_properties
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    @property.realestate = current_user.realestate
    @property.realestate_id = params[:property][:realestate_id] if current_user.admin?

    respond_to do |format|
      if @property.save
        add_pictures
        format.html { redirect_to admin_properties_path, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        @property.update_attribute(:realestate_id, params[:property][:realestate_id]) if current_user.admin?
        add_pictures
        format.html { redirect_to admin_property_path(@property), notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to admin_properties_path, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def unpublish_picture
    @property = Property.find(params[:property_id])
    @property.pictures.find(params[:picture_id]).update_attribute(:published, false)
    respond_to do |format|
      format.js { head :no_content }
    end
  end

  private
  def add_pictures
    if params[:pictures]
      params[:pictures].each do |picture|
        @property.pictures.create(picture.permit(:image, :description)) if picture[:image].present?
      end
    end
  end

  def picture_params
    params.require(:picture).permit(:image, :description, :order)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def property_params
    valid_params = [:ref, :title, :town_id, :user_id, :price_sale, :price_rent, :nrooms,
                    :description, category_ids: [], detail_ids: []]
    params.require(:property).permit(valid_params)
  end

  def current_resource
    @current_resource ||= Property.find(params[:id]) if params[:id]
  end
end
