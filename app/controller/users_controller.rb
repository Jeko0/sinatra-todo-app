class UsersController < ApplicationController
  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      redirect to '/tasks'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:password] == ""
      redirect to '/signup'
    else 
      @user = User.create(name: params[:name], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/tasks"
    end
  end

  get "/login" do 
    if logged_in?
     redirect "/tasks"
    else
      erb :'users/login'
    end
  end

  post "/login" do 
    @user = User.find_by(:name => params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tasks"
    else
      redirect "/login "
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/edit' do 
    @user = User.find_by_id(session[:user_id])
    if @user 
      erb :'users/edit'
    else
      redirect to "/login"
    end
  end

  patch "/edit/:id" do 
    @user = User.find(params[:id])
    @user.name = params[:name] unless params[:name] == ""
    @user.save
    redirect '/tasks'
  end
end