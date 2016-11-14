require 'rails_helper'

describe 'user_signing up' do
    it 'signs up a user if their name is unique' do
        @user = User.create!(:username => "user1")
        @user.username = "user1"
        user = User.find_by_username(@user.username)
        expect(user).to eq @user
    end
    
    it 'throws an error when the usezxcxzcrname is not unique' do 
        User.create!(:username => "user1")
        expect{User.create!(:username => "user1")}.to raise_error(ActiveRecord::RecordInvalid)
    end
end