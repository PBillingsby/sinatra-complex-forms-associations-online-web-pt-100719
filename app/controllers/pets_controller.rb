class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params["pet"])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params["owner"])
      @pet.owner_id = @owner.id
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
    else
      @pet.owner_id = params["pet"]["owner_ids"].to_i
    end
    @pet.update(name: params["pet"]["name"])
    # {"_method"=>"patch", "pet"=>{"name"=>"Chewie Darling", "owner_ids"=>["1"]}, "owner"=>{"name"=>""}, "id"=>"1"}
    redirect to "pets/#{@pet.id}"
  end
end