require 'rails_helper'
describe UsersController do


  
  describe "GET logout" do
    it "logs user out" do
      get :logout
      
    end
  end
  
  describe "post login" do
    it "logs user in" do
      post :login
      
    end
  end
  
    describe "post login" do
    it "logs user in" do
      post :login, {:login_username => 'cavemanjack', :login_password => '123'}
      print response.body
      # expect(@user)
      
    end
  end
  
end 
  