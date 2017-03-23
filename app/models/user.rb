class User < ActiveRecord::Base
  has_secure_password
  has_many :events
  has_many :participations, dependent: :destroy
  has_many :events_participated, through: :participations, source: :event
  has_many :comments, dependent: :destroy
  has_many :events_commented, through: :comments, source: :event

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, :location, :state, presence:true
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: true
  before_create :password, :password_confirmation, length: {minimum: 8}, presence:true
end
