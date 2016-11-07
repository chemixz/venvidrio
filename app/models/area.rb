class Area < ActiveRecord::Base
	has_many :systems , dependent: :destroy

	validates :name, presence: true
	validates :ubication ,presence: true 

 	scope :search_normal, -> (object) { where("#{object[:field]} like ?", "%#{object[:textsearch]}%" )}

end
