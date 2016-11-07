class SystemsController < ApplicationController
  layout "backend"
  before_action :set_system, only: [:show, :edit, :update, :destroy]
  before_action :verify_if_exist_area, only: [:new , :edit , :create]
  before_action :authenticate_admin!, only: [:new , :create , :edit , :destroy , :update]


  # GET /systems
  # GET /systems.json
  def index
    @systems = System.all.paginate(page: params[:page],per_page:20)
  end

  def index_search_systems  #busqueda viene objeto desde form de busqueda y se evian a los scopes
        
      if search_params[:field] == 'area'
        area = System.search_by_area(search_params)
      else
        area = System.search_normal(search_params)
      end
      @systems = area
      render :index
  end
  # GET /systems/1
  # GET /systems/1.json
  def show
  end

  # GET /systems/new
  def new
    @system = System.new
    
  end

  # GET /systems/1/edit
  def edit
  end

  # POST /systems
  # POST /systems.json
  def create
   # raise system_params.to_yaml
    @system = System.new(system_params)

    respond_to do |format|
      if @system.save
        Log.create(description: "Creó el Sistema de <strong> Nombre: </strong> #{@system.name}, en la <strong> Fecha: </strong> #{@system.created_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)
        format.html { redirect_to @system, :notice => { :class => 'info', :body => 'El sistema ha sido creado.'} }
        format.json { render :show, status: :created, location: @system }
      else
        format.html { render :new }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /systems/1
  # PATCH/PUT /systems/1.json
  def update
    elsistema = System.find(params[:id])
    respond_to do |format|
      if @system.update(system_params)
        Log.create(description: "Actualizó el Sistema de <strong> Nombre: </strong> #{elsistema.name},  en la <strong> Fecha: </strong> #{@system.created_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , before_you: "Nombre: #{elsistema.name}, Ubicación: #{elsistema.ubication}, Area: #{elsistema.area.name}", after_you: "Nombre: #{@system.name}, Ubicación: #{@system.ubication}, Area: #{@system.area.name}" , user_id: current_user.id)
        format.html { redirect_to @system, :notice => { :class => 'success', :body => 'El sistema ha sido actualizado.'} }
        format.json { render :show, status: :ok, location: @system }
      else
        format.html { render :edit }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /systems/1
  # DELETE /systems/1.json
  def destroy
    elsistema = System.find(params[:id])
    @system.destroy
      Log.create(description: "Se ha eliminado el <strong> Sistema : #{elsistema.name} </strong> en la <strong> Fecha: </strong> #{Time.new.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)
    
    respond_to do |format|

      format.html { redirect_to systems_url, :notice => { :class => 'danger', :body => "El Sistema: #{elsistema.name}, ha sido eliminado."} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    def verify_if_exist_area
      val_area = Area.all.size()
      if val_area <= 0
        flash[:notice] ={:class=> "danger",:body=>"No hay Áreas creadas."}
        #flash[:notice] = " No hay Áreas creadas"
        redirect_to :back
      else
        @areas = Area.all
      end
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_params
      params.require(:system).permit(:name, :ubication, :area_id)
    end

    def search_params
      params.require(:searcher).permit(:textsearch,  :field )
    end
end
