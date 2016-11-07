json.array!(@user_control_panels) do |user_control_panel|
  json.extract! user_control_panel, :id
  json.url user_control_panel_url(user_control_panel, format: :json)
end
