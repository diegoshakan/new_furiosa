class Announcement < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many_attached :images

  validates :title, :description, :price, presence: true

  validate :images_limit # Validação personalizada para o limite de imagens

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "description", "price" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category", "comments", "images_attachments", "images_blobs", "likes", "subcategory", "user" ]
  end

  private

  def images_limit
    if images.count > 5
      errors.add(:images, "Máximo de 5 imagens permitido")
    end
  end
end
