source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails'
gem 'bcrypt'
gem 'sprockets-rails'
gem 'popper_js'
gem 'bootstrap'
gem 'bootstrap-sass'
gem 'bootstrap-datepicker-rails'
gem 'slim-rails'
gem 'font-awesome-rails'
gem 'carrierwave'
gem 'mini_magick'
gem 'coffee-rails'
gem 'faker'
gem 'fog'
gem 'jbuilder'
gem 'jquery-rails'
gem 'puma'
gem 'sass-rails'
gem 'turbolinks'
gem 'uglifier'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'rails-controller-testing'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
