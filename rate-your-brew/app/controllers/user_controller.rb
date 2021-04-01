class UserController < ApplicationController

    get '/users/signup' do 
        redirect_if_logged_in
        
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.create(
            username: params[:username], 
            password: params[:password]
        )
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
    end

    get '/users/login' do 
        redirect_if_logged_in

        erb :'/users/login'
    end

    post '/users/login' do 
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params["username"]["password"])
            session["user_id"] = user.id
            redirect "/beers"
        # if user not valid, send back to /login
        else
            redirect "/users/login"
        end
    end

    get '/users/:id' do
        @user = User.find(params[:id])
        erb :'/users/show'
    end

    delete '/logout' do 
        redirect_if_not_logged_in
        #logout a user
        # session.clear
        session.delete("user_id")
        redirect "/users/login"
    end

end