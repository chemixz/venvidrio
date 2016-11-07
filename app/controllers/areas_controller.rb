class AreasController < ApplicationController
  layout "backend"
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new , :create , :edit , :destroy , :update]

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all.paginate(page: params[:page],per_page:20)
  end

  def index_search_areas  #busqueda viene objeto desde form de busqueda y se evian a los scopes
      @areas = Area.search_normal(search_params).paginate(page: params[:page],per_page:20)
      render :index
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save

        Log.create(description: "Creó el Area de <strong> Nombre: </strong> #{@area.name}, en la <strong> Fecha: </strong> #{@area.created_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)
        format.html { redirect_to @area, notice: 'La Area ha sido creada.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
   # raise params[:id].to_yaml

    elarea = Area.find(params[:id])
    respond_to do |format|
      if @area.update(area_params)
        Log.create(description: "Actualizo el Area de <strong> Nombre: </strong> #{elarea.name}, en la <strong>Fecha:</strong> #{@area.updated_at.strftime("%d-%m-%Y %H:%M:%S %p")}", before_you: "Nombre: #{elarea.name}, Ubicación: #{elarea.ubication}", after_you: "Nombre: #{@area.name}, Ubicación: #{@area.ubication}", user_id: current_user.id)

        format.html { redirect_to @area, notice: 'La Area ha sido actualizada' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    elarea = Area.find(params[:id])
    @area.destroy
      Log.create(description: "Se ha eliminado el Area de <strong> Nombre: </strong> #{elarea.name}, en la <strong> Fecha: </strong>#{Time.new.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)

    respond_to do |format|
      format.html { redirect_to areas_url, :notice => { :class => 'danger', :body => "La Area: #{elarea.name}, ha sido eliminada."} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :ubication)
    end

    def search_params
      params.require(:searcher).permit(:textsearch,  :field )
    end
end
