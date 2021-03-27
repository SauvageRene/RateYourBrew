class BeerController < ApplicationController

    #Create

    get '/beers/new' do 
        erb :'/beers/new'
    end
    #Create a new beer and save to the DB
    post '/beers' do
        @beer = Beer.create(
            name: params[:name], 
            description: params[:description], 
            abv: params[:abv], 
            rating: params[:rating])

        redirect "/beers/#{@beer.id}"
    end

    #READ 

    get '/beers/:id' do
        @beer = Beer.find(params[:id])

        erb :'/beers/show'
    end

    get '/beers' do 
        @beers = Beer.all #returns an array

        erb :'/beers/index'
    end

    #Update

    get '/beers/:id/edit' do 
        @beer = Beer.find(params[:id])
        erb :'/beers/edit'
    end

    post '/beers/:id' do
        @beer = Beer.find(params[:id])
        @beer.update(
            name: params[:name], 
            description: params[:description], 
            abv: params[:abv], 
            rating: params[:rating]
        )

        redirect "/beers/#{@beer.id}"
    end
    


end