class DestinationsController < ApplicationController
    
    get '/destinations' do 
        @destinations = current_user.destinations
        erb :'destinations/index'
    end

    get '/destinations/new' do
        @destination = Destination.new
        erb :'destinations/new'
    end

    post '/destinations' do 
        @destination = current_user.destinations.build(params[:destination])
        if @destination.save
            redirect '/destinations'
        else
            erb :'destinations/new'
        end
    end

###Dynamic Route###
    get '/destinations/:id/edit' do
        set_destination
        if current_user.id == @destination.user_id
            erb :'destinations/edit'
        else
            redirect '/destinations'
        end
    end

    get '/destinations/:id' do
        #binding.pry
        set_destination
        if @destination
            erb :'destinations/show'
        else
            redirect '/destinations'
        end
    end

    patch '/destinations/:id' do
       set_destination
        if @destination.update(params[:destination])
            redirect "/destinations/#{@destination.id}"
        else
        erb :'destinations/edit'
       end
    end

    delete '/destinations/:id' do 
        set_destination
        if current_user == @destination.user
            @destination.destroy
        end
        redirect '/destinations'
    end

    private
        def set_destination
            @destination = Destination.find_by_id(params[:id])
        end
end