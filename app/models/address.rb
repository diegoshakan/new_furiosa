class Address < ApplicationRecord
  belongs_to :user

  validates :street, :city, :state, :zipcode, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "zipcode", "city", "created_at", "id", "state", "street", "updated_at", "user_id" ]
  end
end
