# frozen_string_literal: true

module Api
  module V1
    class FirebaseAuthenticationsController < ApplicationController
      skip_before_action :authenticate_user, only: %i[auth_with_firebase]

      def auth_with_firebase
        FirebaseIdToken::Certificates.request
        render_error('ログインできませんでした') if data.blank?

        @user = signin(data)

        ender_error('ログイン情報の認証に失敗しました') if @user.present? && !@user.can_login?

        @user = signup(data) if @user.blank?
      end

      private

      def signin(data)
        FirebaseAuthentication.find_by(uid: params[:user_id])&.user
      end

      def signup(data)
        user = nil
        provider = params[:provider]
        permitted_params = auth_firebase_params
        ActiveRecord::Base.transaction do
          user = create_user(data)
          create_firebase_authentication(data, permitted_params, provider, user.id)
        end
        user
      end

      def create_user(data)
        User.create!(
          email: params[:email],
          uid: params[:user_id]
        )
      end

      def create_firebase_authentication(data, params, provider, created_user_id)
        FirebaseAuthentication.create!(
          user_id: created_user_id,
          uid: params[:user_id],
          email: params[:email],
          refresh_token: params[:refresh_token],
          access_token: params[:access_token],
          id_token: token,
          sign_in_provider: provider,
          tenant_id: params[:tenant_id],
          email_verified: params[:email_verified]
        )
      end

      def auth_firebase_params
        params.require(:firebase_authentication).permit(
          :access_token,
          :refresh_token,
          :tenant_id,
          :provider,
          :user_id,
          :email,
          :email_verified
        )
      end

      def token_from_request_headers
        request.headers['Authorization']&.split&.last
      end

      def token
        params[:token] || token_from_request_headers
      end

      # FIXME：JWT認証されてないのでする
      def data
        @data ||= token
      end
    end
  end
end
