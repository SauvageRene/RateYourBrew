class UserController < ApplicationController

    get '/users/signup' do 

        redirect_if_logged_in
        
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.new(
            username: params[:username], 
            password: params[:password]
        )
        if @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
        else
            flash[:error] = "Username unavailable"
            erb :'/users/signup'
        end
    end

    get '/users/login' do 
        redirect_if_logged_in

        erb :'/users/login'
    end

    post '/users/login' do 
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params["password"])
            session["user_id"] = @user.id
            redirect "/users/#{@user.id}"
        # if user not valid, send back to /login
        else
            flash[:error] = "Incorrect username or password, please try again."
            redirect "/users/login"
        end
    end

    get '/users/:id' do
        redirect_if_not_logged_in
        current_user
        erb :'/users/show'
    end

    get '/logout' do 
        redirect_if_not_logged_in
        #logout a user
        # session.clear
        session.clear
        redirect "/users/login"
    end

end