class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/ }

  validates_uniqueness_of :email

  def serialize
    {
      user: serializable_hash(only: %i[email first_name last_name])
    }
  end
end
