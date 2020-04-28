source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv-rails', groups: %i[development test]
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'redis', '~> 4.0'

gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'irb', require: false
  gem 'pry-rails'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'aasm'
gem 'geocoder'
gem 'paper_trail'
gem 'rack-attack'
gem 'sidekiq'
gem 'twilio-ruby', '~> 5.33.1'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
