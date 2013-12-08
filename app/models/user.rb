class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :invites
  has_many :groups, :through => :invites
  has_many :rsvps
  has_many :events, :through => :rsvps
  has_many :comments
  
end
