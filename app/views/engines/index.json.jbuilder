json.array!(@engines) do |engine|
  json.extract! engine, :id, :serial, :code, :brand, :model, :hp, :kw, :frame, :rpm, :hertz, :amperes, :sf, :back_r, :front_r, :mf, :part_c, :install_date, :system_id
  json.url engine_url(engine, format: :json)
end
