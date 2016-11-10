class User < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  attr_accessor :activation_token, :remember_token
  validates :name, presence: true,
                   length: { in: 3..15 },
                   format: { with: /\A[a-zA-Z]+-{0,1}[a-zA-Z]+\z/ }
  validates :surname, presence: true,
                      length: { in: 3..15 },
                      format: { with: /\A[a-zA-Z]+-{0,1}[a-zA-Z]+\z/ }
  validates :gender, presence: true,
                     acceptance: { accept: ['Male', 'Female'], message: "Specify your gender" }
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                       length: { minimum: 5 },
                       format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]*\z/,
                                 message: "must include lower, upper letter and num"}
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
