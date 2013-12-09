class Event < ActiveRecord::Base
  
  belongs_to :group
  has_many :rsvps
  has_many :users, :through => :rsvps
  has_many :comments
  
  validates :title, presence: true
  validates :datetime, presence: true
  validates :location, presence: true
  
end
