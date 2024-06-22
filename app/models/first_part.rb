# frozen_string_literal: true

class FirstPart < ApplicationRecord
  belongs_to :user
  belongs_to :make

  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :make_id, message: 'You can only contribute one part to a make' }
  has_many :informations, dependent: :destroy

  default_scope { order(created_at: :desc) }

  scope :without_second_part, -> {
    joins(:make)
      .where(makes: { id: Make.left_outer_joins(:second_part)
      .where(second_parts: { id: nil })
      .select(:id) })
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[content]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[make user]
  end
end
