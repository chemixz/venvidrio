class HistoriesController < ApplicationController
  layout "backend"
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :verify_if_exist_engines, only: [:new]
  #before_action :set_engnes , only: [:new, :edit]

  # GET /histories
  # GET /histories.json
  def index


    @histories = History.all.descorder
  end


 def search  #busqueda viene objeto desde form de busqueda y se evian a los scopes
      if search_params[:field] == 'serial' or search_params[:field]=='code' 
        history = History.search_by_engines(search_params)
      end
      @histories = history.paginate(page: params[:page],per_page:10)
      render :index
  end
 
  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    if !params[:id].nil?
      @engine = Engine.find(params[:id])
    end
    @history = History.new
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    #raise params.to_yaml
    @history = History.new(history_params)

    respond_to do |format|
      if @history.save
        Log.create(description: "Creó el Historial del motor <strong> Serial: </strong> #{@history.engine.serial} <strong> Codigo: </strong> #{@history.engine.code} en la  <strong> Fecha: </strong> #{@history.created_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)

        format.html { redirect_to @history,  :notice => { :class => 'success', :body => 'La historia ha sido creada.'} }
        format.json { render :show, status: :created, location: @history }
      else
        format.html { render :new }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    historia = History.find(params[:id])

    respond_to do |format|
      if @history.update(history_params)
        Log.create(description: "Actualizó el historial del motor <strong> Serial: </strong> #{historia.engine.serial} <strong> Codigo: </strong> #{historia.engine.code} en la <strong> Fecha: </strong> #{@history.updated_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)

        format.html { redirect_to @history, :notice => { :class => 'success', :body => 'La Historia ha sido actualizada.'}  }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    historia = History.find(params[:id])
    @history.destroy
        Log.create(description: "Se elimino el historial del motor <strong> Serial: </strong> #{historia.engine.serial} <strong> Codigo: </strong> #{historia.engine.code} en la </strong> Fecha: </strong> #{Time.new.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)

    respond_to do |format|
      format.html { redirect_to histories_url, :notice => { :class => 'success', :body => 'La Historia ha sido eliminada.'}  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

     def verify_if_exist_engines
      val_engines = Engine.all.size()
      if val_engines <= 0
        flash[:notice] ={:class=> "danger",:body=>"No hay Motores creados aun."}
        #flash[:notice] = " No hay Áreas creadas"
        redirect_to :back
      end
    end

    def set_engnes
      @engines = Engine.all
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:date, :description, :unmounted_to, :installed_to, :install_by, :notes, :engine_id)
    end

    def search_params
      params.require(:searcher).permit(:textsearch,  :field )
    end
end
