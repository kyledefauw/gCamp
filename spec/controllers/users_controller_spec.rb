require 'rails_helper'

describe UsersController do
  let(:user) {create_user}
  let(:project) {create_project}
  let(:member) {create_membership}
  let(:task) {create_task}
  before do session[:user_id] = user.id
  end

  describe 'GET #index' do
    it 'it redirects a non logged in user to sign_in_path' do
      session.clear
      get :index
      expect(response).to redirect_to sign_in_path
    end

    it 'should render a view for a logged in user' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    it 'logged in user can create user' do
      expect {
        post :create, user: {
          first_name: "Joel",
          last_name: "Cummins",
          email: "joel.cummins#{rand(100000) + 1}@umphreys.com",
          password: "mcgee",
          password_confirmation: "mcgee",
          admin: true }}.to change{User.count}.by(1)

      expect(response).to redirect_to users_path
    end

    it 'logged out user cannot create a user' do
      session.clear
      post :create, user: {name: "party like a rockstar this weekend"}
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #new' do
    it 'a logged in user is able to create a new user object' do
      get :new, user: {name: "can't wait to be done"}
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new view for a logged in user' do
      get :new, user: {name: "doing it"}
      expect(response).to render_template("new")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :new, user: {name: "no hacking"}
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #edit' do
    it 'should have a user item for an owner and render the edit view' do
      get :edit, id: user.id
      expect(response).to render_template("edit")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :edit, id: user.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #show' do
    it 'should have a user item for an owner and render the edit view' do
      get :show, id: user.id
      expect(response).to render_template("show")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :show, id: user.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'PUT #update' do
    it 'logged in user can update user' do
      put :update, id: user.id, user: { name: 'Test' }

      expect(response).to redirect_to users_path
    end

    it 'logged out user cannot update a user' do
      session.clear
      post :update, id: user.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys a user if its the owner' do
      user
      expect{delete :destroy, id: user}.to change{User.all.count}.by(-1)
    end

    it 'a non owner cannot delete the user' do
      session.clear
      delete :destroy, id: user
      expect(response).to redirect_to sign_in_path
    end
  end

end
