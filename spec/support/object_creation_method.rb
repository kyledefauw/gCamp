def sign_in_user
  user = User.new(first_name: 'Jeff', last_name: 'Austin', email: 'jeff@austin.com', password: 'mandolin', password_confirmation: 'mandolin', admin: true)
  user.save!
  visit sign_in_path
  fill_in :email, with: 'jeff@austin.com'
  fill_in :password, with: 'mandolin'
  click_button 'Sign In'
end

def create_project(options = {})
  defaults = {
    name: "Crush Code"
  }
  project = Project.create!(defaults.merge(options))
end

def create_task(options={})
  Task.create!({
    description: "Finish gCamp",
    project_id: create_project.id,
    date: "4/21/2015"
  }.merge(options))
end

def create_user(options={})
  User.create!({
    first_name: "Joel",
    last_name: "Cummins",
    email: "joel.cummins#{rand(100000) + 1}@umphreys.com",
    password: "mcgee",
    password_confirmation: "mcgee",
    admin: true
  }.merge(options))
end

def create_comment(options={})
  Comment.create!({
    content: "I'll write what I want",
    user_id: create_user.id,
    task_id: create_task.id
  }.merge(options))
end

def create_membership(options={})
  Membership.create!({
    role: "Owner",
    project_id: create_project.id,
    user_id: create_user.id
  }.merge(options))
end
