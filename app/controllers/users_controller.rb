
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

      puts params
      @user = User.find_by_username(params[:login_username])
      #initializing class variables to nil to meet cucumber tests

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
            save_user_game_info
        end
        set_user_stats
        set_user_game_songs
        set_user_game_records

    end
    
    def set_user_stats
        puts @user.wins
        puts @user.losses

        if @user.wins.include?("w") || @user.losses.include?("l")
            correct_answers_number = @user.wins.length
            incorrect_answers_number = @user.losses.length
            if correct_answers_number != 0 || incorrect_answers_number != 0
                @correct_inccorect_percentage = "#{((correct_answers_number.to_f/incorrect_answers_number)*100).round}%"
            else 
                puts "no percentage"
                @correct_inccorect_percentage = "#{0.to_s}%"
            end
            @correct_answers = correct_answers_number.to_s
            @incorrect_answers = incorrect_answers_number.to_s
        else
            @correct_answers = '0%'
            @incorrect_answers = '0%'
            @correct_inccorect_percentage = '0%'
        end
    end
    
    def set_user_game_records
        @game_records = []
        if @user.records.include?(",")
            game_record_strings_array = @user.records.split(",")
            for i in 1...game_record_strings_array.length
                @game_records[i-1] = game_record_strings_array[i].split("")
            end
        end
    end
    
    def set_user_game_songs
        @game_songs = []
        if @user.songs.include?("|||") 
            puts 'got songs'
            game_song_strings_array = @user.songs.split("|||")
            for i in 1...game_song_strings_array.length
                @game_songs[i-1] = game_song_strings_array[i].split("~")
            end
        end
    end
    
    def save_user_game_info 
        record_array = session["record"].split("")
        if record_array.length == 8
            for i in 0...record_array.length
                puts record_array[i]
                if record_array[i].strip == 'w'
                    game_wins = "#{game_wins}#{record_array[i]}"
                else 
                    game_losses = "#{game_losses}#{record_array[i]}"
                end
            end
            #using strings to store number of wins and losses due to migration troubles
            @user.wins = "#{@user.wins}#{game_wins}"
            @user.losses = "#{@user.losses}#{game_losses}"
            #same goes for records and songs, they use delimiters to designate between games
            #arrays in migrations are super hard janet
            @user.records = "#{@user.records},#{session[:record]}"
            @user.songs = "#{@user.songs}|||#{session[:song_names]}"
            session[:game_ended] = 'false'
            @user.save!
        end
    end
    
    def create
        begin
            session.clear
            session["song_names"] ||= ""
            session["record"] ||= ""
            session["song_names"] ||= ""


            user = User.create!(username: params[:username], pasword: params[:password])
            @user = User.find_by_username(params[:username])
            
            @user.wins ||= ""
            @user.losses ||= ""
            @user.songs ||= ""
            @user.records ||= ""
            @user.save!
            set_user_stats
            set_user_game_songs
            set_user_game_records
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
