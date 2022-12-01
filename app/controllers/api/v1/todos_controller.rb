# frozen_string_literal: true

# TEST:こちらテストで作ったcontroller
module Api
  module V1
    class TodosController < ApplicationController
      skip_before_action :authenticate_user, only: %i[index update]

      def index
        @todos = [{ id: 1, content: '1番目のコンテンツです', completed: true },
                  { id: 2, content: '2番目のコンテンツです', completed: true }]
      end

      def update; end
    end
  end
end
