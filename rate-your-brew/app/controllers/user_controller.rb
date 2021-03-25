class UserController < ApplicationController

    get '/users/signup' do 
        
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.create

    end

end