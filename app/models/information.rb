# frozen_string_literal: true

class Information < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :make, optional: true
  belongs_to :first_part, optional: true
  belongs_to :second_part, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
