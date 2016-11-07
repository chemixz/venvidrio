json.array!(@areas) do |area|
  json.extract! area, :id, :name, :ubication
  json.url area_url(area, format: :json)
end

