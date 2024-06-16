# frozen_string_literal: true

class Make < ApplicationRecord
  belongs_to :user
  has_one :first_part, dependent: :destroy
  has_one :second_part, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
  has_many :informations, dependent: :destroy

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

  def create_information_like!(current_user)
    # すでにいいねしているか確認
    temp = Information.where(['visitor_id = ? and visited_id = ? and make_id = ? and action = ? ', current_user.id, user_id, id, 'like'])
    # いいねしていない場合のみ、通知を作成
    if temp.blank?
      information = current_user.active_informations.new(
        make_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分のmakeに対するいいねの場合は通知を作成しない
      if information.visitor_id == information.visited_id
        information.checked = true
      end
      information.save if information.valid?
    end
  end

  def create_information_first_part!(current_user)
    # すでに上の句を作成しているか確認
    temp = Information.where(['visitor_id = ? and visited_id = ? and make_id = ? and action = ? ', current_user.id, user_id, id, 'first_part'])
    # 上の句を作成していない場合のみ、通知を作成
    if temp.blank?
      information = current_user.active_informations.new(
        make_id: id,
        visited_id: user_id,
        action: 'first_part'
      )
      # 自分のmakeに対する上の句の場合は通知を作成しない
      if information.visitor_id == information.visited_id
        information.checked = true
      end
      information.save if information.valid?
    end
  end

  def create_information_second_part!(current_user)
    # すでに下の句を作成しているか確認
    temp = Information.where(['visitor_id = ? and visited_id = ? and make_id = ? and action = ? ', current_user.id, user_id, id, 'second_part'])
    # 下の句を作成していない場合のみ、通知を作成
    if temp.blank?
      information = current_user.active_informations.new(
        make_id: id,
        visited_id: user_id,
        action: 'second_part'
      )
      # 自分のmakeに対する下の句の場合は通知を作成しない
      if information.visitor_id == information.visited_id
        information.checked = true
      end
      information.save if information.valid?
    end
  end

  private

  def at_least_one_part_present
    return unless first_part.nil? && second_part.nil?

    errors.add(:base, 'どちらかの句（上の句または下の句）が存在する必要があります')
  end
end
