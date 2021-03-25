class BeerController < ApplicationController

    #Create

    get '/beers/new' do 
        erb :'/orders/new'
    end
    #Create a new beer and save to the DB
    post '/beers' do
        @beer = Beer.create(
            name: params[:name], 
            description: params[:description], 
            ABVpercentage: params[:abv], 
            rating: params[:rating])

        redirect "beers/#{@beer.id}"
    end

    #READ 

    get 'beers/:id' do
        @order = Order.find(params[:id])

        erb :'/beers/show'
    end

    post '/orders' do 
        @orders = Order.all #returns an array

        erb :'/orders/index'
    end

    #Update
    


end