class User < ApplicationRecord
validates :name, presence: true
validates :email, presence: true

#attr_accessible :name, :email, :password, :password_confirmation, :activity
validates :password, presence: true, length: { minimum: 6 }
validates :password_confirmation, presence: true

before_create :create_remember_token

has_secure_password

has_many :projects, dependent: :destroy
has_many :tasks, :through => :projects
has_many :points, dependent: :destroy

before_save { |user| user.email = email.downcase }
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                   uniqueness: true


def activity_update
  self.update_attribute(:activity, Time.now)
end

def all_points
  count = 0
  self.points.each do |p|
    count =+ p.quantity
  end
  return count
end

private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
