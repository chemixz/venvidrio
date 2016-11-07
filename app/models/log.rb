class Log < ActiveRecord::Base
  belongs_to :user
  scope :dorder, ->{ order("logs.created_at DESC") }
end
