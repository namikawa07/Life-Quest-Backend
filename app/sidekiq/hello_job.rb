# frozen_string_literal: true

class HelloJob
  include Sidekiq::Job

  def perform(*_args)
    # Do something
    Rails.logger.debug 'Hello Sidekiq'
  end
end
