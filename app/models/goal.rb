class Goal < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :start_time, presence: true
  validates :start_time, uniqueness: { scope: :user_id }
end
