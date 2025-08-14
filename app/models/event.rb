class Event < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :start_time, uniqueness: { scope: :user_id }
end
