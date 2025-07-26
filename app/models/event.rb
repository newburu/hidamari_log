class Event < ApplicationRecord
  validates :content, presence: true
end
