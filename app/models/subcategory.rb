class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :announcements, dependent: :destroy

  validates :name, presence: true
end
