require './config/environment'

class ApplicationController < Sinatra::Base
  @trying = nil

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/fwitter' do
    send_file File.join(settings.public_folder, 'fwitter.tar.gz')
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      #More code, but only a single database access this way.
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end
