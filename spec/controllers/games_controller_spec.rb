require 'rails_helper'
describe GamesController do

  describe "post users" do 
    it "creates a new user" do 
      post :create 
    end
  end
  
  describe 'get show' do
    it 'shows the user page' do
      get :show, {:id => 1}
    end
  end
  
  describe 'get index' do 
    it 'shows the games page' do
      expect {get :index}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

=begin
  describe 'get edit' do
    it 'does nothing' do
      get :edit, {:id => 1}
    end
  end
=end
  