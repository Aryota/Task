class UsersTask < ApplicationRecord
  belongs_to :user
  belongs_to :task
  enum is_owner: { false: 0, true: 1 }
end
