class Engine < ActiveRecord::Base
  belongs_to :system
  has_many :histories , dependent: :destroy

  validates :volts ,presence: true 
  
  validates :system , presence: true

  scope :descorder, ->{ order("engines.created_at DESC") }

  scope :search_normal, -> (object) { where("#{object[:field]} like ?", "%#{object[:textsearch]}%" )}
  scope :search_by_area, -> (object) { includes(:area).where("areas.name like ?", "%#{object[:textsearch]}%").references(:area) }
  scope :search_by_system, -> (object) { includes(:system).where("systems.name like ?", "%#{object[:textsearch]}%").references(:system) }
 
end
