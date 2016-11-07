require 'test_helper'

class EnginesControllerTest < ActionController::TestCase
  setup do
    @engine = engines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:engines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create engine" do
    assert_difference('Engine.count') do
      post :create, engine: { amperes: @engine.amperes, back_r: @engine.back_r, brand: @engine.brand, frame: @engine.frame, front_r: @engine.front_r, hertz: @engine.hertz, hp: @engine.hp, install_date: @engine.install_date, kw: @engine.kw, m_frecuency: @engine.m_frecuency, model: @engine.model, part_compatibility: @engine.part_compatibility, rpm: @engine.rpm, serial: @engine.serial, sf: @engine.sf, system_id: @engine.system_id }
    end

    assert_redirected_to engine_path(assigns(:engine))
  end

  test "should show engine" do
    get :show, id: @engine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @engine
    assert_response :success
  end

  test "should update engine" do
    patch :update, id: @engine, engine: { amperes: @engine.amperes, back_r: @engine.back_r, brand: @engine.brand, frame: @engine.frame, front_r: @engine.front_r, hertz: @engine.hertz, hp: @engine.hp, install_date: @engine.install_date, kw: @engine.kw, m_frecuency: @engine.m_frecuency, model: @engine.model, part_compatibility: @engine.part_compatibility, rpm: @engine.rpm, serial: @engine.serial, sf: @engine.sf, system_id: @engine.system_id }
    assert_redirected_to engine_path(assigns(:engine))
  end

  test "should destroy engine" do
    assert_difference('Engine.count', -1) do
      delete :destroy, id: @engine
    end

    assert_redirected_to engines_path
  end
end
