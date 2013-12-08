class Group < ActiveRecord::Base
  
  has_many :invites
  has_many :users, :through => :invites
  has_many :events
  has_many :rsvps
  
  validates :name, presence: true
  
end
