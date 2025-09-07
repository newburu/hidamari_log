class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :goals, dependent: :destroy

  validates :good_new_character_limit, numericality: { only_integer: true, greater_than: 0, allow_nil: true }

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    name = auth_hash[:info][:name]

    self.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = name
    end
  end
end
