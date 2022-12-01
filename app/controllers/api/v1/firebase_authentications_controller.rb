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
        FirebaseAuthentication.find_by(uid: data['user_id'])&.user
      end

      def signup(data)
        user = nil
        provider = select_provider(data)
        permitted_params = auth_firebase_params
        ActiveRecord::Base.transaction do
          user = create_user(data)
          create_firebase_authentication(data, permitted_params, provider, user.id)
        end
        user
      end

      def create_user(data)
        User.create!(
          email: data['email'],
          uid: data['user_id']
        )
      end

      def create_firebase_authentication(data, params, provider, created_user_id)
        FirebaseAuthentication.create!(
          user_id: created_user_id,
          uid: data['user_id'],
          email: data['email'],
          refresh_token: params[:refresh_token],
          access_token: params[:access_token],
          id_token: token,
          sign_in_provider: provider,
          tenant_id: params[:tenant_id],
          email_verified: data['email_verified']
        )
      end

      # rubocop:disable Style/HashLikeCase
      def select_provider(data)
        case data['firebase']['sign_in_provider']
        when 'password'
          'email_with_password'
        when 'apple.com'
          'apple'
        when 'google.com'
          'google'
        when 'twitter.com'
          'twitter'
        when 'facebook.com'
          'facebook'
        end
      end
      # rubocop:enable Style/HashLikeCase

      def auth_firebase_params
        params.require(:firebase_authentication).permit(
          :access_token,
          :refresh_token,
          :tenant_id
        )
      end

      def token_from_request_headers
        request.headers['Authorization']&.split&.last
      end

      def token
        params[:token] || token_from_request_headers
      end

      def data
        @data ||= FirebaseIdToken::Signature.verify token
      end
    end
  end
end
