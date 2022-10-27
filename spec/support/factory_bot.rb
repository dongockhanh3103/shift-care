# frozen_string_literal: true

require 'factory_bot_rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:all) do
    DatabaseCleaner.clean_with :truncation, pre_count: true
  end

  config.before(:suite) do
  end

  config.after(:suite) do
  end

  config.before(:all, type: :request) do
    RefreshToken.destroy_all
    User.destroy_all
    user = User.create!(email: 'admin@example.com', name: 'admin', password: 'admin@123', password_confirmation: 'admin@123', role: :admin)
    access_token = RefreshTokens::StoreService.execute(user.id)
    @final_access_token = "Bearer #{access_token}"
    @headers = { ACCEPT: :'application/json', AUTHORIZATION: @final_access_token }
    @headers_with_no_auth = { ACCEPT: :'application/json' }
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.append_after do
    DatabaseCleaner.clean
  end
end
