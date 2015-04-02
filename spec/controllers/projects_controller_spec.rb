require 'rails_helper'

describe ProjectsController do
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
    it 'logged in user can create project' do
      expect {
        post :create, project: {name: "test"}
      }.to change {Project.count}.by(1)

      expect(response).to redirect_to project_tasks_path(Project.last)
    end

    it 'logged out user cannot create a project' do
      session.clear
      post :create, project: {name: "party like a rockstar this weekend"}
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #new' do
    it 'a logged in user is able to create a new project object' do
      get :new, project: {name: "can't wait to be done"}
      expect(assigns(:project)).to be_a_new(Project)
    end

    it 'renders the new view for a logged in user' do
      get :new, project: {name: "doing it"}
      expect(response).to render_template("new")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :new, project: {name: "no hacking"}
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #edit' do
    it 'should have a project item for an owner and render the edit view' do
      get :edit, id: project.id
      expect(response).to render_template("edit")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :edit, id: project.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #show' do
    it 'should have a project item for an owner and render the edit view' do
      get :show, id: project.id
      expect(response).to render_template("show")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :show, id: project.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'PUT #update' do
    it 'logged in user can update project' do
      create_membership(user_id: user.id, project_id: project.id)
      put :update, id: project.id, project: { name: 'Test' }

      expect(response).to redirect_to project_path(project)
    end

    it 'logged out user cannot update a project' do
      session.clear
      post :update, id: project.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys a project if its the owner' do
      member
      project
      expect{delete :destroy, id: project}.to change{Project.all.count}.by(-1)
    end

    it 'a non owner cannot delete the project' do
      session.clear
      delete :destroy, id: project
      expect(response).to redirect_to sign_in_path
    end
  end

end
