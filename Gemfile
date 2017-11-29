source "http://rubygems.org"
ruby '2.3.4'

gem "sinatra-activerecord"

group :production, :test do # <<<< :development, not devlopment
  gem 'sqlite3'
  gem 'mysql2'
  gem "rake"
end
group :development do
end
gem 'pry'
gem 'sinatra'
gem 'shotgun'
gem 'rest-client'