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
    @pet = Pet.create(name: params[:pet][:name])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      owner = Owner.find_or_create_by(params[:pet][:owner_ids])
      @pet.owner = owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  post '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.name = params["pet"]["name"]
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      owner = Owner.find(params[:pet][:owner_ids]).first
      @pet.owner = owner
    end
    @pet.save
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end
end
