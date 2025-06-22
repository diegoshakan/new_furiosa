class Like < ApplicationRecord
  belongs_to :user
  belongs_to :announcement

  validates_uniqueness_of :user_id, scope: :announcement_id
end
