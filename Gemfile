source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.3.1'
gem 'rails', '~> 5.1.5'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'byebug'
gem 'pry-rails'
gem 'pry-byebug'

group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

gem 'httparty'
gem 'simple_form'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'activerecord-postgis-adapter'
gem 'slim-rails'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
end
