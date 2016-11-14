require 'rails_helper'

describe 'reading from file' do
    it 'reads from a text file and obtains a list of songnames and artists' do
        songs = []
        File.open("/home/ubuntu/workspace/songs.csv", "r").each_line do |line|
            data = line.split(',')
            @song = data[0]
            @artist = data[1]
            songs.push(data)
        end
        expect(songs[0][0]).to eq("Caroline")
        expect(songs[0][1]).to eq("Amine\r\n")
    end
end
describe 'setting up game' do 
    before do
       @songs = []
        File.open("/home/ubuntu/workspace/songs.csv", "r").each_line do |line|
            data = line.split(',')
            @song = data[0]
            @artist = data[1]
            @songs.push(data)
        end 
    end
    
    it 'gets four random numbers for each song' do 
        number_of_songs = @songs.length
        @numbers = []
        while @numbers.length < 4     
           new_num = rand(0...number_of_songs)
           if !@numbers.include?(new_num)
               @numbers.push new_num
           end
        end
        expect(@numbers.length).to eq(4)
        @numbers.each do |number|
            expect(number).to be_within(@songs.length/2).of(@songs.length/2)
        end
    end
    
    it 'chooses four unique songs for a round' do 
        choices_indexes = [6, 2, 8, 3]
        @songs_choices = [@songs[choices_indexes[0]], @songs[choices_indexes[1]], @songs[choices_indexes[2]], @songs[choices_indexes[3]]]
        @songs_choices.each do |song|
            expect(song[0]).to match(/.*/)
            expect(song[1]).to match(/.*/)
        end
    end
    
    it 'chooses one song to be the answer song' do 
        choices_indexes = [6, 2, 8, 3]
        @songs_choices = [@songs[choices_indexes[0]], @songs[choices_indexes[1]], @songs[choices_indexes[2]], @songs[choices_indexes[3]]]
        randnum = rand(0...4)
        @answer_song = @songs_choices[randnum]
        expect(@answer_song).to eq(@songs_choices[randnum])
    end
    
    it 'get lyrics from the API' do 
    end
        
end
=begin
        choices_indexes = game_controller.get_four_rand_numbers(songs.length)
        choices_indexes.each do |i|
            choices_indexes.each do |j|
                if i != j do
                    expect(choices_indexes[i]).not_to eq(choices_indexes[j])
                end
            end
        end
    end
end
=end

