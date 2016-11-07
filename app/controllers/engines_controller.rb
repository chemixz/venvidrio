class EnginesController < ApplicationController
  layout "backend"
  before_action :set_engine, only: [:show, :edit, :update, :destroy , :reporte]
  before_action :verify_if_exist_system, only: [:new]
  before_action :set_areas, only: [:new, :edit , :create]
  before_action :authenticate_admin!, only: [:new , :create , :edit , :destroy , :update]

  # GET /engines
  # GET /engines.json
  def index
     @engines  = Engine.all.descorder.paginate(page: params[:page],per_page:20)
  end

  def consulta_general
    @engines  = Engine.all.paginate(page: params[:page],per_page:50)
  end

  # GET /engines/1
  # GET /engines/1.json
  def show
  end

  def reporte
  end
  
  def index_search_engines

      if search_params[:field] == 'system' 
        @eng = Engine.search_by_system(search_params)
      end
      if search_params[:field] == 'serial' or search_params[:field]=='code' or search_params[:field]=='brand' or search_params[:field]=='frame' or search_params[:field] == 'system.area'
        @eng = Engine.search_normal(search_params)
      end
      @engines = @eng.paginate(page: params[:page],per_page:50)
      render :index
  end
 
  # GET /engines/new
  def new
    @engine = Engine.new
   
  end

  # GET /engines/1/edit
  def edit
  end

  # POST /engines
  # POST /engines.json
  def create
    #raise engine_params.to_yaml
    @engine = Engine.new(engine_params)

    respond_to do |format|
      if @engine.save
        Log.create(description: "Creó el Motor <strong>Serial:</strong> #{@engine.serial} <strong> Codigo: </strong> #{@engine.code} en la <strong> Fecha: </strong> #{@engine.created_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)
        format.html { redirect_to @engine, :notice => { :class => 'success', :body => 'El motor ha sido creado.'} }
        format.json { render :show, status: :created, location: @engine }
      else
        format.html { render :new }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /engines/1
  # PATCH/PUT /engines/1.json
  def update

    elmotor = Engine.find(params[:id]) 
    respond_to do |format|
      if @engine.update(engine_params)
        Log.create(description: "Actualizó el Motor <strong> Serial: </strong> #{elmotor.serial}, <strong> Codigo: </strong> #{elmotor.code} en la  <strong> Fecha: </strong> #{@engine.updated_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , before_you: "Serial: #{elmotor.serial}, Codigo: #{elmotor.code}, Marca: #{elmotor.brand}, Modelo: #{elmotor.model}, Area: #{elmotor.system.area.name}, Sistema: #{elmotor.system.name}, HP: #{elmotor.hp}, KW: #{elmotor.kw}, Frame: #{elmotor.frame}, RPM: #{elmotor.rpm}, Hertz: #{elmotor.hertz}, Amperaje: #{elmotor.amperes}, Factor de Servicio: #{elmotor.sf}, Rodamiento Delantero: #{elmotor.front_r}, Rodamiento Trasero: #{elmotor.back_r}, Frecuencia de Mtto: #{elmotor.mf}, Respuesto de: #{elmotor.part_c}, Fecha de Instalación: #{elmotor.install_date}, Voltios: #{elmotor.volts}", after_you: "Serial: #{@engine.serial}, Codigo: #{@engine.code}, Marca: #{@engine.brand}, Modelo: #{@engine.model}, Area: #{@engine.system.area.name}, Sistema: #{@engine.system.name}, HP: #{@engine.hp}, KW: #{@engine.kw}, Frame: #{@engine.frame}, RPM: #{@engine.rpm}, Hertz: #{@engine.hertz}, Amperaje: #{@engine.amperes}, Factor de Servicio: #{@engine.sf}, Rodamiento Delantero: #{@engine.front_r}, Rodamiento Trasero: #{@engine.back_r}, Frecuencia de Mtto: #{@engine.mf}, Respuesto de: #{@engine.part_c}, Fecha de Instalación: #{@engine.install_date}, Voltios: #{@engine.volts}", user_id: current_user.id)

        format.html { redirect_to @engine, :notice => { :class => 'success', :body => 'El motor ha sido actualizado.'} }
        format.json { render :show, status: :ok, location: @engine }
      else
        format.html { render :edit }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engines/1
  # DELETE /engines/1.json
  def destroy
    elmotor = Engine.find(params[:id])
    @engine.destroy
        Log.create(description: "Se elimino el Motor <strong> Serial: </strong> #{elmotor.serial} <strong> Codigo: </strong> #{elmotor.code} en la Fecha: #{Time.new.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to engines_url, :notice => { :class => 'danger', :body => "El motor de Código: #{elmotor.code}, ha sido eliminado."} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engine
      @engine = Engine.find(params[:id])
    end
    
    def verify_if_exist_system
      val_system = System.all.size()
      if val_system <= 0
        flash[:notice] ={:class=> "danger",:body=>"No hay Sistemas creados."}
        redirect_to :back
      end
    end

    def set_areas
       @areas = Area.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engine_params
      params.require(:engine).permit(:serial, :code, :brand, :model, :hp, :kw, :frame, :rpm, :hertz, :amperes, :sf, :back_r, :front_r, :mf, :part_c, :install_date, :volts, :system_id)
    end

    def search_params
      params.require(:searcher).permit(:textsearch,  :field )
    end
end
