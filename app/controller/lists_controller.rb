class ListsController < ApplicationController
  get '/lists/new' do
    redirect_if_not_logged_in
    erb :'/lists/new'
  end

  post '/lists/new' do
    @user = current_user
    redirect "/lists/new" if params[:name] == "" 

    list = @user.lists.create(:name => params[:name])
    todo = list.todos.create(:name => params[:tasks][:name]) unless params[:tasks][:name] == ""

    redirect '/tasks'
  end

    get '/lists/:id/edit' do
    redirect_if_not_logged_in
    @list = List.find_by_id(params[:id])
    if @list && @list.user == current_user
      erb :'lists/edit'
    else
      redirect to 'tasks'
    end
  end

  patch '/lists/:id' do
    @list = List.find_by_id(params[:id])
    @list.name = params[:name]
    @list.save
    redirect '/tasks'
  end

  get '/lists/:id/delete' do
    @list = List.find_by_id(params[:id])
    if @list && @list.user == current_user
      erb :'lists/delete'
    else
      redirect to 'tasks'
    end
    erb :'lists/delete'
  end

  delete '/lists/:id' do
    @list = List.find_by_id(params[:id])
    @list.destroy
    redirect '/tasks'
  end
end