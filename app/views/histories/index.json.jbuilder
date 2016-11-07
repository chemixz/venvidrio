json.array!(@histories) do |history|
  json.extract! history, :id, :date, :description, :unmounted_to, :installed_to, :install_by, :notes, :engine_id
  json.url history_url(history, format: :json)
end
