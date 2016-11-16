
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

      session[:new_game] = 'true'
      if @user == nil 

          flash[:notice] = "Invalid username or password"
          flash.keep(:notice)
          redirect_to users_path
      else
          if params[:login_password] == @user.pasword
            session[:username] = @user.username
             #puts @user
              session[:user_id] = @user.id
              session[:game_ended] = 'false'
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
        # print session["record"]
        session[:new_game] = 'true'
        if session[:game_ended] == 'true'
            @user.records << session["record"]
            @user.songs << session["song_names"]
            record_array = session["record"].split("")
            for i in 0...record_array.length
                puts record_array[i]
                if record_array[i].strip == 'w'
                    game_wins = "#{game_wins}#{record_array[i]}"
                else 
                    game_losses = "#{game_losses}#{record_array[i]}"
                end
            end
            @user.wins = "#{@user.wins}#{game_wins}"
            @user.losses = "#{@user.losses}#{game_losses}"
            session[:game_ended] = 'false'
            @user.save!
        end
        print 'wins'
        puts @user.wins
        print 'losses'
        puts @user.losses
        print 'songs'
        print @user.songs
        @user.songs.each do |title|
          puts title
        end
        print 'records'
        @user.records.each do |title|
          puts title
        end
end

        
    
    def create
        begin
            session.clear
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
