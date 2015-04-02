require 'rails_helper'

describe TasksController do
  let(:user) {create_user}
  let(:project) {create_project}
  let(:member) {create_membership}
  let(:task) {create_task(project_id: project.id)}
  before do session[:user_id] = user.id
  end

  describe 'GET #index' do
    it 'it redirects a non logged in user to sign_in_path' do
      session.clear
      get :index, project_id: project.id
      expect(response).to redirect_to sign_in_path
    end

    it 'should render a view for a logged in user' do
      get :index, project_id: project.id
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    it 'logged in user can create task' do
      member
      project
      expect {
        post :create, project_id: project.id, task: {description: "test"}
      }.to change {Task.count}.by(1)

      expect(response).to redirect_to project_task_path(project, Task.last)
    end

    it 'logged out user cannot create a task' do
      session.clear
      post :create, project_id: project.id, task: {description: "party like a rockstar this weekend"}
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #new' do
    it 'a logged in user is able to create a new task object' do
      get :new, project_id: project.id, task: {description: "can't wait to be done"}
      expect(assigns(:task)).to be_a_new(Task)
    end

    it 'renders the new view for a logged in user' do
      get :new, project_id: project.id, task: {description: "doing it"}
      expect(response).to render_template("new")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :new, project_id: project.id, task: {description: "no hacking"}
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #edit' do
    it 'should have a task item for an owner and render the edit view' do
      get :edit, project_id: project.id, id: task.id
      expect(assigns(:task)).to eq(task)
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :edit, project_id: project.id, id: task.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'GET #show' do
    it 'should have a task item for an owner and render the edit view' do
      get :show, project_id: project.id, id: task
      expect(response).to render_template("show")
    end

    it 'a logged out user is redirected to sign_in_path' do
      session.clear
      get :show, project_id: project.id, id: task.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'PUT #update' do
    it 'logged in user can update task' do
      create_membership(user_id: user.id, project_id: project.id)
      put :update, project_id: project.id, id: task.id, task: { description: 'Test' }

      expect(response).to redirect_to project_task_path(project, task)
    end

    it 'logged out user cannot update a task' do
      session.clear
      post :update, project_id: project.id, id: task.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys a task if its the owner' do
      project
      task
      expect{delete :destroy, project_id: project.id, id: task}.to change{Task.all.count}.by(-1)
    end

    it 'a non owner cannot delete the task' do
      session.clear
      delete :destroy, project_id: project.id, id: task
      expect(response).to redirect_to sign_in_path
    end
  end

end
