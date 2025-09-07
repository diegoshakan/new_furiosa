class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :announcement

  validates :content, presence: true
end
