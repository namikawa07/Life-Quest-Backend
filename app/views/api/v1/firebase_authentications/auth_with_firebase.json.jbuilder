# frozen_string_literal: true

json.extract! @user,
              :uuid,
              :status,
              :name,
              :self_introduction,
              :thumbnail_url,
              :email
