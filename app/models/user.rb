class User < ApplicationRecord
<<<<<<< HEAD
    has_many :articles, dependent: :destroy
    has_many :votes, dependent: :destroy
    validates :name, presence: true
=======
    has_many :articles
    has_many :votes
    validates :name, presence: true, uniqueness: true, length: { in: 2..50 }
>>>>>>> feature-login
end
