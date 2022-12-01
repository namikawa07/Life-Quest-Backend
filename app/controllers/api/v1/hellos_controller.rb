# frozen_string_literal: true

# TEST:こちらテストで作ったcontroller
module Api
  module V1
    class HellosController < ApplicationController
      skip_before_action :authenticate_user, only: %i[index update destroy]
      def index
        @hello = 'こんにちは'
      end

      def update
        # hello_data = params[:hello_data]

        head :ok
      end

      def destroy
        Rails.logger.debug 'deleteされました！！'
        head :ok
      end
    end
  end
end
