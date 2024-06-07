class FirstPart < ApplicationRecord
  belongs_to :user
  belongs_to :make

  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :make_id, message: 'You can only contribute one part to a make' }

  def self.ransackable_attributes(auth_object = nil)
    %w[content]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[make user]
  end
end
