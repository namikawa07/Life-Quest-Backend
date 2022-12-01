# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def create_uuid
    count = 0
    loop do
      uuid = SecureRandom.uuid
      count += 1
      raise Mediable::Error::CollisionUuidError if count > 100
      return uuid if self.class.find_by(uuid: uuid).blank?
    end
  end
end
