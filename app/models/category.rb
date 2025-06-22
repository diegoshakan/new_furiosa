class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  has_many :announcements, dependent: :destroy

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "name", "updated_at" ]
  end
end
