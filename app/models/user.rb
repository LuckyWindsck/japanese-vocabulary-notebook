class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_writer :login
  validate :validate_username
  validates :username, presence: :true, uniqueness: { case_sensitive: true }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :vocabularies

  def login
   @login || self.username || self.email
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["username = :value OR email = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
