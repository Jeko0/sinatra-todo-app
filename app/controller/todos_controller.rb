class TodosController < ApplicationController
  get '/tasks' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists
    erb :'tasks/show'
  end

  get '/tasks/new' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = List.all
    erb :'/tasks/new'
  end

  post '/tasks/new' do
    Todo.create(:name => params[:name], :user_id => session[:user_id], :list_id => params[:list_id])
    redirect '/tasks'
  end

  get '/tasks/new/:id' do
    redirect_if_not_logged_in
    @list = List.find_by_id(params[:id])
    if @list = current_user.lists.find_by_id(params[:id])
      erb :'/tasks/create_task'
    else
      redirect to '/tasks'
    end

  end

  post '/tasks/new/:id' do
    @list = List.find_by_id(params[:id])
    Todo.create(:name => params[:name], :user_id => session[:user_id], :list_id => params[:id])
    redirect '/tasks'
  end

  get '/tasks/:id/edit' do
    @task = Todo.find_by_id(params[:id])
    if @task.user_id = current_user.todos.find_by_id(params[:id])
      erb :'/tasks/edit'
    else
      redirect to '/tasks'
    end
  end

  patch '/tasks/:id' do
    @task = Todo.find_by_id(params[:id])
    @task.name = params[:name]
    @task.save
    redirect '/tasks'
  end

  get '/tasks/:id/delete' do
    @task = Todo.find_by_id(params[:id])
    if task = current_user.todos.find_by_id(params[:id])
      erb :'/tasks/delete'
    else
      redirect to '/tasks'
    end
  end

  delete '/tasks/:id' do
    @task = Todo.find_by_id(params[:id])
    @task.destroy
    redirect '/tasks'
  end
end