class Event < ActiveRecord::Base
  scope :recent, -> { order(created_at: :desc) }
end
