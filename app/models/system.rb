class System < ActiveRecord::Base
  	belongs_to :area
  	has_many :engines , dependent: :destroy
  
  	validates :name, presence: true
	validates :ubication ,presence: true 
	validates :area_id ,presence: true

 	scope :search_normal, -> (object) { where("#{object[:field]} like ?", "%#{object[:textsearch]}%" )}
 	scope :search_by_area, -> (object) { includes(:area).where("areas.name like ?", "%#{object[:textsearch]}%").references(:area) }

end
