class Article < ApplicationRecord
  belongs_to :author, class_name'User'
  belongs_to :category
  has_many :votes
  include ImageUploader::Attachment(:image)
  validates :title, presence: true
end
