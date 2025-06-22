class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  has_many :announcements, dependent: :destroy

  validates :name, presence: true
end
