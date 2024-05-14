class FirstPart < ApplicationRecord
  belongs_to :user
  belongs_to :make

  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :make_id, message: 'You can only contribute one part to a make' }
end
