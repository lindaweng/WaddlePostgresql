source "http://rubygems.org"
ruby '2.3.4'

gem "sinatra-activerecord"

group :production, :test do # <<<< :development, not devlopment
  
  gem 'mysql2'
  gem "rake"
end
group :development do
  gem 'sqlite3'
end
gem 'pry'
gem 'sinatra'
gem 'shotgun'
gem 'rest-client'