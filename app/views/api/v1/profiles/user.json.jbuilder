# frozen_string_literal: true

if @current_user
  json.extract! @current_user,
                :uuid,
                :status,
                :name,
                :self_introduction,
                :thumbnail_url,
                :email
end
