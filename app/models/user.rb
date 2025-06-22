class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true, update_only: true

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "email", "encrypted_password", "fantasy_name", "id", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "address", "announcements", "comments", "likes" ]
  end
end
