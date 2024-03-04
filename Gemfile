source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.1.3.2'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise'
gem 'haml-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg'
gem 'puma'
gem 'redis'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'importmap-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'sgcop', github: 'SonicGarden/sgcop'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'guard'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
end
