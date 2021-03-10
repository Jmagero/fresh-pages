class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :votes, dependent: :destroy
  has_many :article_categories
  has_many :categories, through: :article_categories, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true, length: { in: 3..200 }
  validates :text, presence: true
  validates :title, presence: true

  scope :select_featured_article, -> { order('votes_count DESC NULLS LAST').first }
end
