class Event < ActiveRecord::Base
  scope :recent, -> { order(created_at: :desc) }
  has_many :comments, as: :commentable
end
