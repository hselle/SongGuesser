class GamesController < ApplicationController
    require_relative 'voicerss_tts'
    @question_result = '------------'
    def game_params
      #params.require(:game).permit(:users, :songs, :winner, :loser, :genre, :start_time, :end_time)
    end
    def show

    end
    
    def create
        
        if params[:artist] == session[:correct_artist]
            flash[:notice] = "YOU'RE RIGHT!"
            answer = "correct"
        else 
            flash[:notice] = "WRONG"
            answer = "wrong"
        end
        
        #adds the question game status to array
        session[:question_array] ||= []
        session[:question_array] << answer
        redirect_to games_path
    end
    
    def index 
        songs = []
        File.open("songs.csv", "r").each_line do |line|
            data = line.split(',')
            @song = data[0]
            @artist = data[1]
            songs.push(data)
        end
        choices_indexes = get_four_rand_numbers(songs.length)
        @songs_choices = [songs[choices_indexes[0]], songs[choices_indexes[1]], songs[choices_indexes[2]], songs[choices_indexes[3]]]
        @answer_song = @songs_choices[rand(0...4)]
        # print @songs_choices
        print @answer_song[0]
        print @answer_song[1]
        session[:correct_artist => @answer_song[0]]
        session[:correct_artist] = @answer_song[0]
        key = '159f7589d4e9ee7d513581b74a5e69b8'
        track_id = get_track_id(@answer_song[1], @answer_song[0])
        lyrics = get_lyrics(track_id)
        sound_string = get_sound_string(lyrics[0..300])
        @sound_string = sound_string
        puts @question_result
        
        
        
        #checks the parameters for the question position
        @question_num = session[:question_num] ||= 0  
        @question_num += 1
        
        if @question_num > 8
            session.clear
            @question_num = 1
        end
    
        session[:question_num] = @question_num
        @question_array = session[:question_array] ||= []
        
    end
    
    def get_four_rand_numbers(number_of_songs)
        numbers = []
        while numbers.length < 4     
            new_num = rand(0...number_of_songs)
           if !numbers.include?(new_num)
               numbers.push new_num
           end
        end
        return numbers
    end 
    
        
            
    def get_track_id(artist, song)
        key = '159f7589d4e9ee7d513581b74a5e69b8'
        uri = URI.parse("https://api.musixmatch.com/ws/1.1/track.search?format=json&q_artist=#{artist}&q_track=#{song}&quorum_factor=1&apikey=#{key}")
        track_id_response = Net::HTTP.get_response(uri)
        # print response.body
        parsed_json = JSON.parse(track_id_response.body)
        track_id = parsed_json['message']['body']['track_list'][0]['track']['track_id']
        return track_id
    end
       
    def get_lyrics(track_id)
        key = '159f7589d4e9ee7d513581b74a5e69b8'

        uri = URI.parse("https://api.musixmatch.com/ws/1.1/track.lyrics.get?format=json&apikey=#{key}&track_id=#{track_id}")
        lyrics_response = Net::HTTP.get_response(uri)
        parsed_json = JSON.parse(lyrics_response.body)
        lyrics = parsed_json['message']['body']['lyrics']['lyrics_body']
        return lyrics
    end
    def get_sound_string(lyrics)
        voice = VoiceRSS.speech({
            'key' => 'a0ce51728bfb415f9423a6b9851ca4bc',
            'hl' => 'en-us',
            'src' => lyrics,
            'r' => '0',
            'c' => 'mp3',
            'f' => '44khz_16bit_stereo',
            'ssml' => 'false',
            'b64' => 'true'
        })
        return voice['response']
    end
  
end