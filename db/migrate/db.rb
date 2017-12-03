require 'active_record'

ActiveRecord::Base.establish_connection({
  adapter:  'mysql2',
  host: 'IP 3306',
  username: 'lindaweng',
  password: '',
  database: 'waddle'
})