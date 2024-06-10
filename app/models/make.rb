# frozen_string_literal: true

class Make < ApplicationRecord
  belongs_to :user
  has_one :first_part, dependent: :destroy
  has_one :second_part, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user

  # Makeモデルのfirst_partとsecond_partのネストされた属性を許可
  # content属性が空でもOK
  accepts_nested_attributes_for :first_part, reject_if: proc { |attributes| attributes['content'].blank? }
  accepts_nested_attributes_for :second_part, reject_if: proc { |attributes| attributes['content'].blank? }

  # 少なくとも一つのパートが存在する必要あり
  validate :at_least_one_part_present

  # ransackで検索可能な属性を定義
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id user_id]
  end

  # ransackで検索可能な関連を定義
  def self.ransackable_associations(_auth_object = nil)
    %w[first_part second_part user]
  end

  private

  def at_least_one_part_present
    return unless first_part.nil? && second_part.nil?

    errors.add(:base, 'どちらかの句（上の句または下の句）が存在する必要があります')
  end
end
