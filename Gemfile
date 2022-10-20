source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "bootsnap", require: false
gem "devise"
gem "jwt", "~> 2.5"
gem "ordinare"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "rails", "~> 7.0.4"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "pry"
  gem "faker"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 6.0", ">= 6.0.1"
  gem "shoulda-matchers", "~> 5.2"
end

group :development do
  # gem "spring"
end


