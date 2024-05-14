class Make < ApplicationRecord
  belongs_to :user
  has_one :first_part, dependent: :destroy
  has_one :second_part, dependent: :destroy

  accepts_nested_attributes_for :first_part, reject_if: proc { |attributes| attributes['content'].blank? }
  accepts_nested_attributes_for :second_part, reject_if: proc { |attributes| attributes['content'].blank? }

  validate :at_least_one_part_present

  private

  def at_least_one_part_present
    return unless first_part.nil? && second_part.nil?

    errors.add(:base, 'At least one part (first or second) must be present')
  end
end
