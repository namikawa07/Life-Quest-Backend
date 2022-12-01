# frozen_string_literal: true

class FirebaseAuthentication < ApplicationRecord
  enum status: { valided: 0, invalided: 1, deleted: 2 }
  enum sign_in_provider: { email_with_password: 0, apple: 1, google: 2, twitter: 3, facebook: 4 }

  belongs_to :user

  before_create :default_settings

  def default_settings
    self.status = :valided if status.blank?
  end
end
