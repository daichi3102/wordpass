# frozen_string_literal: true

class SecondPart < ApplicationRecord
  belongs_to :user
  belongs_to :make

  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :make_id, message: 'You can only contribute one part to a make' }
  has_many :informations, dependent: :destroy

  default_scope { order(created_at: :desc) }

  scope :without_first_part, lambda {
    joins(:make)
      .where(makes: { id: Make.left_outer_joins(:first_part)
      .where(first_parts: { id: nil })
      .select(:id) })
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[content]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[make user]
  end
end
