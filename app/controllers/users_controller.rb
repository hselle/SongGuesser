
# require_relative 'voicers_tts'
class UsersController < ApplicationController
    # include ESpeak
    # require 'rubygems'
    # require 'espeak-ruby'
    # include ESpeak
    
    
    def user_params
        #
        params.require(:user).permit(:username, :password, :wins, :losses, :songs, :records, :song_images)
    end

    def login
      #puts params[:login_username]
      #puts params[:login_password]
      session["song_names"] = ""
      session["record"] = ""
      session["song_names"] = ""


      @user = User.find_by_username(params[:login_username])
      puts @user.records[0]

      @user.records = ['llllllll']
      session[:new_game] = 'true'
      if @user == nil 
          puts "------------"
          puts "found it to be nil"
          puts "___________"
          flash[:notice] = "Invalid username or password"
          flash.keep(:notice)
          redirect_to users_path
      else
          if params[:login_password] == @user.pasword
            session[:username] = @user.username
             #puts @user
              session[:user_id] = @user.id
              redirect_to user_path(@user)
          else
              flash[:notice] = "Invalid username or password"
              flash.keep(:notice)
              redirect_to users_path  
          end
      end
    end
    
    def show
        session["song_names"] ||= ""
        session["record"] ||= ""
        session["song_names"] ||= ""
        id = params[:id]
        @user = User.find(id)
        @user.records = ['llllllll']
        @user.wins = 'w'
        print @user.records[0]
        # print session["record"]
        session[:new_game] = 'true'
        print session["song_names"].split("~")
        @songs_to_display = session["song_names"].split("~")
        @record = session["record"].split
    end

        
    
    def create
        begin
            user = User.create!(username: params[:username], pasword: params[:password])
            # speech = Speech.new("READY TO HEAR RAP OVERLY ARTICULATED?")
            # speech.speak
            @user = User.find_by_username(params[:username])
            session["user_id"] = @user.id
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
