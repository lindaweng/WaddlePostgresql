require 'bundler'
Bundler.require
require "sinatra"
require "sinatra/activerecord"
require "./models.rb"
require "./modelsAccount.rb"
set :database, "sqlite3:myblogdb.sqlite3"

class ApplicationController < Sinatra::Base
    get '/' do
        erb :index
    end
    
    get '/show_all' do
        erb :show_all
    end
    
    get '/account' do
        erb :account
    end
    
    get '/login' do
        erb :login
    end
    
    post '/login' do
        @username = params[:username]
        @password = params[:password]
        count = 0
        @accounts = Account.all
        @accounts.each do |account|
            if account.username == @username and account.password == @password
                @id = account.id
            else
                count += 1
            end
        end
        if count != 0
                @output = "Wrong username or password."
                erb :login
        end
        @userAccount = Account.find(@id)
        @name = @userAccount.name
        @age = @userAccount.age
        @email = @userAccount.email
        erb :account
    end
    
    post '/create_account' do
        if params[:name] != "" && params[:age] != "" && params[:email] != "" && params[:username] != "" && params[:password] != ""
            # find if there is already an existing username
            @username = params[:username]
            @accounts = Account.all
            count = 0
            @accounts.each do |account|
                if account.username == username
                    count += 1
                end
            end
            if count != 0
                @output = "That username is already taken. Please choose a different username."
                erb :sign_up
            end
            @account = Account.create(name: params[:name], age: params[:age], email: params[:email], username: params[:username], password: "#{params[:password]}")
            @username = params[:username]
            erb :account
        else
            @output = "Please Complete All Fields" 
            erb :sign_up
        end 
    end

    post '/groups' do
        @id = params[:id]
        userSchool = params[:start]
        # iterate through Post.all and find the matching location
        @posts = Post.all
        count = 0
        @location_array = []
        @time_array = []
        @destination_array = []
        @idnum_array = []
        @method_array = []
        @posts.each do |post|
            if userSchool.downcase == post.location.downcase
                @location = post.location
                @destination = post.destination
                @time = post.time
                @idnum = post.id
                @method = post.date
                
                @location_array.push(post.location)
                @destination_array.push(post.destination)
                @time_array.push(post.time)
                @idnum_array.push(post.id)
                @method_array.push(post.date)
                
                count += 1
            end
        end
        if count == 0
            @output = "There are currently no waddles available :("
            erb :no_results
        else 
            erb :results
        end

    end
    
    get '/groupsagain/:start' do
        userSchool = params[:start]
        # iterate through Post.all and find the matching location
        @posts = Post.all
        @location_array = []
        @time_array = []
        @destination_array = []
        @idnum_array = []
        @method_array = []
        @posts.each do |post|
            if userSchool.downcase == post.location.downcase
                @location = post.location
                @destination = post.destination
                @time = post.time
                @idnum = post.id
                @method = post.date
                
                @location_array.push(post.location)
                @destination_array.push(post.destination)
                @time_array.push(post.time)
                @idnum_array.push(post.id)
                @method_array.push(post.date)
                
            end
        end
        @output = "Please Enter in Valid Waddle Info"
        erb :results
    end

    post '/create_groups' do
        @id = params[:id]
        if params[:location] != "" && params[:destination] != "" && params[:time] != "" && params[:name] != "" && params[:method]
            @post = Post.create(location: params[:location], destination: params[:destination], date: params[:method], time: params[:time], penguins: "#{params[:name]}")
            @location = params[:location]
            erb :show
        else
            @output = "Please Complete All Fields" 
            erb :no_results
        end
    end

    post '/submit' do
        @id = params[:id]
        userEnd = params[:destination]
        userMethod = params[:method]
        @posts = Post.all
        count = 0
        @posts.each do |post|
            if userEnd.downcase == post.destination.downcase and userMethod.downcase == post.date.downcase
                @location = post.location
                @destination = post.destination
                @time = post.time
                @method = post.date
                @idnum = post.id
                count += 1
            
            end
        end
        if count == 0
            userSchool = params[:start]
            redirect "/groupsagain/#{userSchool.gsub(" ","%20")}"
        else
            @post = Post.find(@idnum)
            @name = Account.find(@id).name
            @post.update(penguins: (@name + ", " + @post.penguins).chomp(", "))
            erb :show 
        end
    end
end