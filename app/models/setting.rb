class Setting < ApplicationRecord
  def self.good_and_new_character_limit
    find_by(key: 'good_and_new_character_limit')&.value&.to_i || 250
  end
end
