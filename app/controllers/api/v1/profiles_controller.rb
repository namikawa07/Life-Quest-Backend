# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      skip_before_action :authenticate_user, only: %i[user]
      def user
        @current_user = current_user if current_user
      end
    end
  end
end
