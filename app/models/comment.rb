class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  scope :recent, -> { order(created_at: :desc) }
end
