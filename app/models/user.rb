class User < ApplicationRecord
  has_secure_password
  validates :name ,presence: true
  validates :email, presence: true, uniqueness: true

  has_many :users_tasks
  has_many :tasks, through: :users_tasks
end
