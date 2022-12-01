# frozen_string_literal: true

class User < ApplicationRecord
  before_create :default_settings

  enum status: { normal: 0, deleted: 1, admin: 2 }

  has_many :firebase_authentications, dependent: :restrict_with_exception

  def default_settings
    self.status = :normal if status.blank?
    self.name = init_random_name if name.blank?
    self.uuid = create_uuid
    self.thumbnail_url = 'default-thumbnail-url'
  end

  def init_random_name(str_len = 8)
    SecureRandom.alphanumeric str_len
  end

  def can_login?
    !deleted?
  end
end
