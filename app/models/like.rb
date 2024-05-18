class Like < ApplicationRecord
  belongs_to :user
  belongs_to :make

  validates :user_id, uniqueness: { scope: :make_id }
end
