class User < ApplicationRecord
  mount_uploader :picture, PictureUploader
  attr_accessor :remember_token, :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_picture

  def crop_picture
    picture.recreate_versions! if crop_x.present?
  end

  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories
  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :received_invites, class_name: 'Invite',
                              foreign_key: 'recipient_id'
  has_many :sent_invites, class_name: 'Invite',
                          foreign_key: 'sender_id',
                          dependent: :destroy
  has_many :received_allocations, class_name: 'Allocation',
                                  foreign_key: 'recipient_id'
  has_many :sent_allocations, class_name: 'Allocation',
                              foreign_key: 'sender_id',
                              dependent: :destroy

  before_save :email_downcase

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[a-z]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validate :picture_size

  # returns hash digest of given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # remembers user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # adds user to team
  def join(team)
    teams << team
  end

  # remove user from team
  def leave(team)
    teams.delete(team)
  end

  # returns true if a user is a member of the team
  def member?(team)
    teams.include?(team)
  end

  private

    def email_downcase
      self.email = email.downcase
    end

    def picture_size
      if picture.size > 3.megabytes
        errors.add(:picture, "should be less than 3MB")
      end
    end
end
