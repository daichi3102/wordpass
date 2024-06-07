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

  # ransackerを使ってカスタム
  ransacker :first_part_content_or_second_part_content_or_user_name_cont, formatter: proc { |value|
    first_part_ids = Make.joins(first_part: :user).where('first_parts.content ILIKE ? OR users.name ILIKE ?', "%#{value}%", "%#{value}%").pluck(:id)
    second_part_ids = Make.joins(second_part: :user).where('second_parts.content ILIKE ? OR users.name ILIKE ?', "%#{value}%", "%#{value}%").pluck(:id)
    # 上記の2つの配列を結合して重複を削除
    ids = first_part_ids | second_part_ids
    ids.present? ? ids : nil
  } do |parent|
    parent.table[:id]
  end

  # ransackで検索可能な属性を定義
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id user_id first_part_content_or_second_part_content_or_user_name_cont]
  end

  # ransackで検索可能な関連を定義
  def self.ransackable_associations(auth_object = nil)
    %w[first_part second_part user]
  end

  private

  def at_least_one_part_present
    return unless first_part.nil? && second_part.nil?

    errors.add(:base, 'At least one part (first or second) must be present')
  end
end
