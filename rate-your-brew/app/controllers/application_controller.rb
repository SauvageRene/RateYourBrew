require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
    use Rack::Flash, :sweep => true
  end

  get "/" do
    redirect_if_not_logged_in
    erb :welcome
  end

  helpers do
    def current_user
      # memoization
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def redirect_if_not_logged_in
      redirect "/users/login" unless logged_in?
    end

    def redirect_if_logged_in
      redirect "/users/show" if logged_in?
    end

    def total_beers
      beer = Beer.all.length
    end

    def latest_beer
      display_beer = current_user.beers.last

      if display_beer == nil 
        "You haven't rated any beers yet!"
      else
        display_beer.name
      end
    end
    
  end

end
