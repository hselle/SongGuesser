
# require_relative 'voicers_tts'
class UsersController < ApplicationController
    # include ESpeak
    # require 'rubygems'
    # require 'espeak-ruby'
    # include ESpeak
    
    
    def user_params
        #, :wins, :losses
        params.require(:user).permit(:username, :password)
    end

    def login
      #puts params[:login_username]
      #puts params[:login_password]
      print session["song_names"] = ""
      print session["record"] = ""

      @user = User.find_by_username(params[:login_username])
      session[:new_game] = 'true'
      if @user == nil 
          flash[:notice] = "Invalid username or password"
          flash.keep(:notice)
          redirect_to users_path
      else
          if params[:login_password] == @user.pasword
            session[:username] = @user.username
             #puts @user
              redirect_to user_path(@user)
          else
              flash[:notice] = "Invalid username or password"
              flash.keep(:notice)
              redirect_to users_path  
          end
      end
      session[:user_id] = @user.id
    end
    
    def show
        id = params[:id]
        @user = User.find(id)
        print session["record"]
        session[:new_game] = 'true'
        print session["song_names"].split("~")
    end

        
    
    def create
        begin
            user = User.create!(username: params[:username], pasword: params[:password])
            # speech = Speech.new("READY TO HEAR RAP OVERLY ARTICULATED?")
            # speech.speak
            @user = User.find_by_username(params[:username])
            redirect_to user_path(@user)
            
        rescue ActiveRecord::RecordInvalid
            flash[:notice] = "Username already exists."
            render "index"
        end
    end
    
    def index
        
    end
    
    def destroy
        
    end
    
    def logout
        session.clear
        redirect_to "/users"
    end


end
