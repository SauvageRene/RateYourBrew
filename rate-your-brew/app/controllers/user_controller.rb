class UserController < ApplicationController

    get '/users/signup' do 
        
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.create(
            username: params[:username], 
            password: params[:password]
        )
        sessions[:user_id] = @user.id
        redirect "/users/#{@user.id}"
    end

    get '/users/:id' do
        @user = User.find(params[:id])
        erb :'/users/show'
    end




end