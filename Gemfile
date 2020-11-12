source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'devise'
gem 'rails-i18n', '~> 6.0'
gem 'devise-i18n'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'carrierwave'
gem 'rmagick'
gem 'data-confirm-modal'
gem 'kaminari'
gem 'ransack'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-mini-profiler', require: false
gem 'jp_prefecture'
gem 'fog-aws'
gem 'dotenv-rails'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '4.0.1'
  gem 'factory_bot_rails'
  gem 'rubocop-airbnb'
end

group :test do
  gem 'capybara'
  gem "rspec_junit_formatter"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'bullet'
end

group :production, :staging do
  gem 'unicorn'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
