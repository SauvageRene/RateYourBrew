class BeerController < ApplicationController

    #Create

    get '/beers/new' do 
        redirect_if_not_logged_in
        erb :'/beers/new'
    end

    get '/beers' do 
        redirect_if_not_logged_in

        @beers = current_user.beers #returns an array
        
        erb :'/beers/index'
    end
    #Create a new beer and save to the DB
    post '/beers' do
        redirect_if_not_logged_in
        
        @beer = current_user.beers.build(
             params[:beer])
        

        # redirect "/beers/#{@beer.id}"
        if @beer.save
            redirect "/beers/#{@beer.id}"
        else
            flash[:error] = 
            "Error #{beer.errors.full_messages.join(", ")}"
        end
    end

    #READ 

    get '/beers/:id' do
        redirect_if_not_logged_in
        redirect_if_not_authorized
        @beer = Beer.find(params[:id])

        erb :'/beers/show'
    end

    # get '/beers' do 
    #     @beers = Beer.all #returns an array

    #     erb :'/beers/index'
    # end

    #Update

    get '/beers/:id/edit' do 
        redirect_if_not_logged_in
        redirect_if_not_authorized
        
        erb :'/beers/edit'
    end

    patch '/beers/:id' do 
        redirect_if_not_authorized
        @beer.update(
            name: params[:name], 
            description: params[:description], 
            abv: params[:abv], 
            rating: params[:rating]
        )

        redirect "/beers/#{@beer.id}"
    end

    # Delete

    delete '/beers/:id' do 
        redirect_if_not_authorized
        @beer.destroy
        redirect "/beers"
    end

    private 

    def redirect_if_not_authorized
        @beer = Beer.find_by_id(params[:id])
        if @beer.user_id != session["user_id"]
            redirect "/beers"
        end
    end


end