
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
      @user = User.find_by_username(params[:login_username])
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
    end
    
    def show
        id = params[:id]
        @user = User.find(id)
        # songs = []
        # File.open("/home/ubuntu/workspace/songs.csv", "r").each_line do |line|
        #     data = line.split(',')
        #     @song = data[0]
        #     @artist = data[1]
        #     songs.push(data)
        # end
        # choices_indexes = get_four_rand_numbers(songs.length)
        # @songs_choices = [songs[choices_indexes[0]], songs[choices_indexes[1]], songs[choices_indexes[2]], songs[choices_indexes[3]]]
        # @answer_song = @songs_choices[rand(0...4)]
        # print @songs_choices
        # print @answer_song
        # artist = 'D.R.A.M.'
        # song = 'broccoli'
        # key = '159f7589d4e9ee7d513581b74a5e69b8'
        # track_id = get_track_id(artist, song)
        # lyrics = get_lyrics(track_id)
        # sound_string = get_sound_string(lyrics)
        # @sound_string = sound_string
    end
    
    # def get_song_names
    #     all_songs = []
    #     File.open("/home/ubuntu/workspace/songs.csv", "r").each_line do |line|
    #         data = line.split(',')
    #         print data
    #         all_songs.push data
    #     end
    #     print all_songs
    # end
    
    # def get_four_rand_numbers(number_of_songs)
    #     numbers = []
    #     while numbers.length < 4     
    #         new_num = rand(0...number_of_songs)
    #       if !numbers.include?(new_num)
    #           numbers.push new_num
    #       end
    #     end
    #     return numbers
    # end 
    
        
            
    # def get_track_id(artist, song)
    #     key = '159f7589d4e9ee7d513581b74a5e69b8'
    #     uri = URI.parse("https://api.musixmatch.com/ws/1.1/track.search?format=json&q_artist=#{artist}&q_track=#{song}&quorum_factor=1&apikey=#{key}")
    #     track_id_response = Net::HTTP.get_response(uri)
    #     # print response.body
    #     parsed_json = JSON.parse(track_id_response.body)
    #     track_id = parsed_json['message']['body']['track_list'][0]['track']['track_id']
    #     return track_id
    # end
       
    # def get_lyrics(track_id)
    #     key = '159f7589d4e9ee7d513581b74a5e69b8'
    #     uri = URI.parse("https://api.musixmatch.com/ws/1.1/track.search?format=json&q_artist=#{@artist}&q_track=#{@song}&quorum_factor=1&apikey=#{key}")
    #     track_id_response = Net::HTTP.get_response(uri)
    #     # print response.body
    #     parsed_json = JSON.parse(track_id_response.body)
    #     track_id = parsed_json['message']['body']['track_list'][0]['track']['track_id']
    #     uri = URI.parse("https://api.musixmatch.com/ws/1.1/track.lyrics.get?format=json&apikey=#{key}&track_id=#{track_id}")
    #     lyrics_response = Net::HTTP.get_response(uri)
    #     parsed_json = JSON.parse(lyrics_response.body)
    #     lyrics = parsed_json['message']['body']['lyrics']['lyrics_body']
    #     return lyrics
    # end
    # def get_sound_string(lyrics)
    #     voice = VoiceRSS.speech({
    #         'key' => 'a0ce51728bfb415f9423a6b9851ca4bc',
    #         'hl' => 'en-us',
    #         'src' => lyrics,
    #         'r' => '0',
    #         'c' => 'mp3',
    #         'f' => '44khz_16bit_stereo',
    #         'ssml' => 'false',
    #         'b64' => 'true'
    #     })
    #     return voice['response']
    # end
    
    # def start_new_game
        
    
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
