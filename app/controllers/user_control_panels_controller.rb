class UserControlPanelsController < ApplicationController
  layout "backend"
  before_action :set_user_control_panel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_super!
  # GET /user_control_panels
  # GET /user_control_panels.json
  def index
    @user_control_panels = User.all.paginate(page: params[:page],per_page:20)
  end

  # GET /user_control_panels/1
  # GET /user_control_panels/1.json
  def show
  end

  # GET /user_control_panels/new
  def new
    @user_control_panel = User.new
  end

  # GET /user_control_panels/1/edit
  def edit
  end

  # POST /user_control_panels
  # POST /user_control_panels.json
  def create
    
    @user_control_panel = User.new(user_control_panel_params)
        

    respond_to do |format|
      if @user_control_panel.save
        Log.create(description: "Creó el usuario <strong>Nombre:</strong> #{@user_control_panel.full_name} <strong> Email: </strong> #{@user_control_panel.email} en la <strong> Fecha: </strong> #{@user_control_panel.created_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)

        format.html { redirect_to user_control_panel_path(@user_control_panel), :notice => { :class => 'success', :body => 'El usuario ha sido creado.'} }
        format.json { render :show, status: :created, location: @user_control_panel }
      else
        format.html { render :new }
        format.json { render json: @user_control_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_control_panels/1
  # PATCH/PUT /user_control_panels/1.json
  def update

    #raise user_control_panel_params.to_yaml
    usuario = User.find(params[:id])
    #auxiliar ={"full_name"=>usuario.full_name, "full_last_name"=>usuario.full_last_name, "email"=>usuario.email, "role"=>usuario.role , "credential" => usuario.credential } 
    
    respond_to do |format|
      if @user_control_panel.update(user_control_panel_params)
        Log.create(description: "Actualizó el Usuario <strong> Nombre: </strong> #{usuario.full_name} <strong> Email: </strong> #{usuario.email} en la  <strong> Fecha: </strong> #{usuario.updated_at.strftime("%d-%m-%Y %H:%M:%S %p")}" , before_you: "Nombre: #{usuario.full_name} , Apellido: #{usuario.full_last_name} , Email: #{usuario.email} , Rol: #{usuario.role} Carnet: #{usuario.credential} ", after_you: "Nombre: #{@user_control_panel.full_name} , Apellido: #{@user_control_panel.full_last_name} , Email: #{@user_control_panel.email} , Rol: #{@user_control_panel.role} Carnet: #{@user_control_panel.credential}" , user_id: current_user.id)
        format.html { redirect_to user_control_panel_path(@user_control_panel) , :notice => { :class => 'info', :body => 'El usuario ha sido actualizado.' } }
        format.json { render :show, status: :ok, location: @user_control_panel }
      else
        format.html { render :edit }
        format.json { render json: @user_control_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_control_panels/1
  # DELETE /user_control_panels/1.json
  def destroy
    usuario = User.find(params[:id])

    @user_control_panel.destroy
    Log.create(description: "Se elimino el Usuario <strong> Nombre: </strong> #{usuario.full_name} <strong> Email: </strong> #{usuario.email} en la Fecha: #{Time.new.strftime("%d-%m-%Y %H:%M:%S %p")}" , user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to user_control_panels_url, :notice => { :class => 'success', :body => 'El usuario ha sido eliminado.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_control_panel
      @user_control_panel = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_control_panel_params
      params.require(:user_control_panel).permit(:full_name, :full_last_name, :email, :password, :password_confirmation , :role , :credential )
    end
     
end
