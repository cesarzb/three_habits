source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "rails", "~> 7.0.4"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'devise'
gem 'devise-jwt'
gem 'rswag'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry', '~> 0.13.1'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
end

group :development do
end


gem "dockerfile-rails", ">= 1.5", :group => :development
