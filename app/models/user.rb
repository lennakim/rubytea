class User < ActiveRecord::Base
  scope :recent, -> { order(created_at: :desc) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_admin(oth_user)
    oth_user.update_attribute(role: :admin) if self.admin?
  end

  def admin?
    role == "admin" || role == :admin
  end
end
