require 'rails_helper'
describe UsersController do


  
  describe "GET logout" do
    it "logs user out" do
      get :logout
      
    end
  end
  

  
  describe "post login" do
    it "logs user in" do
      post :login, {:login_username => 'cavemanjack', :login_password => '123'}
      # print response.should have
      # expect(@user)
      
    end
  end
  
  describe "post create user" do 
    it "creates a new user" do 
      post :create 
    end
  end
  
  describe "post users index" do 
    it 'shows the login page' do
      post :index
    end
  end
  
  
  describe 'get show' do
    it 'shows the user page' do
      post :create
      get :show, {:id => 1}
    end
  end
end
=begin

 describe 'deletes: ' do
    it 'deletes a user' do 
      delete :destroy, {:id => 1}
    end
  end
  describe 'get edit' do
    it "does nothing" do
      get :edit, {:id => 1}
    end
  end
end 
=end
  