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
    
    get '/account/:id' do
        @id = params[:id]
        @userAccount = Account.find(@id)
        @name = @userAccount.name
        @age = @userAccount.age
        @username = @userAccount.username
        @password = @userAccount.password
        @email = @userAccount.email
        @waddles = @userAccount.waddles
        erb :account
    end
    
    get '/login' do
        erb :login
    end
    
    get '/sign_up' do
        erb :sign_up
    end
    
    get '/edit/:id' do
        @id = params[:id]
        erb :edit
    end
    
    post '/login' do
        @username = params[:username]
        @password = params[:password]
        count = 0
        @accounts = Account.all
        @accounts.each do |account|
            if account.username == @username and account.password == @password
                @id = account.id
                puts @id
                count += 1
            end
        end
        if count == 0
                @output = "Wrong username or password."
                erb :login
        else
            @userAccount = Account.find(@id)
            @name = @userAccount.name
            @age = @userAccount.age
            @email = @userAccount.email
            @waddles = @userAccount.waddles
            erb :account
        end
       
        
    end
    
    post '/create_account' do
        if params[:name] != "" && params[:age] != "" && params[:email] != "" && params[:username] != "" && params[:password] != ""
            # find if there is already an existing username
            @username = params[:username]
            @accounts = Account.all
            count = 0
            @accounts.each do |account|
                if account.username == @username
                    count += 1
                end
            end
            if count != 0
                @output = "That username is already taken. Please choose a different username."
                erb :sign_up
            end
            @userAccount = Account.create(name: params[:name], age: params[:age], email: params[:email], username: params[:username], password: params[:password], waddles: "")
            @id = @userAccount.id
            @username = params[:username]
            @name = params[:name]
            @age = params[:age]
            @email = params[:email]
            @waddles = ""
            erb :account
        end 
    end

    post '/edit_account' do
        @id = params[:id]
        @userAccount = Account.find(@id)
        if params[:name] != ""
            @userAccount.update(name: params[:name])
        elsif params[:age] != ""
            @userAccount.update(age: params[:age])
        elsif params[:email] != ""
            @userAccount.update(email: params[:email])
        elsif params[:username] != ""
            @userAccount.update(username: params[:username])
        elsif params[:password] != ""
            @userAccount.update(password: params[:password])
        end
        @name = @userAccount.name
        @age = @userAccount.age
        @email = @userAccount.email
        @username = @userAccount.username
        @password = @userAccount.password
        @waddles = @userAccount.waddles
        erb :account
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
        @id = params[:id]
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
        @userAccount = Account.find(@id)
        if params[:location] != "" && params[:destination] != "" && params[:time] != "" && params[:method]
            
            @post = Post.create(location: params[:location], destination: params[:destination], date: params[:method], time: params[:time], penguins: "#{@userAccount.name}")
            @location = params[:location]
            @userAccount.update(waddles: (@post.date + " from " + @post.location + " to " + @post.destination + " at " + @post.time + ", " + @userAccount.waddles).chomp(", "))
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
        time = params[:time]
        @posts = Post.all
        count = 0
        @posts.each do |post|
            if userEnd.downcase == post.destination.downcase and userMethod.downcase == post.date.downcase and time == post.time
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
            @userAccount = Account.find(@id)
            @name = @userAccount.name
            @post.update(penguins: (@name + ", " + @post.penguins).chomp(", "))
            @userAccount.update(waddles: (@post.date + " from " + @post.location + " to " + @post.destination + " at " + @post.time + ", " + @userAccount.waddles).chomp(", "))
            erb :show 
        end
    end
end