class History < ActiveRecord::Base
  belongs_to :engine

    scope :descorder, ->{ order("histories.created_at DESC") }
    scope :search_by_engines, -> (object) { includes(:engine).where("engines.#{object[:field]} like ?", "%#{object[:textsearch]}%").references(:engine) }
end
