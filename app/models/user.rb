class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    name = auth_hash[:info][:name]

    # providerとuidでユーザーを探すか、なければ新しく作成する
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
    end
  end
end
