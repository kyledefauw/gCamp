require 'rails_helper'

feature 'Existing users CRUD task' do

  before :each do
    User.destroy_all
    Task.destroy_all
    Project.destroy_all
  end

  scenario "can create a task" do
    project = Project.create!(name: 'Dig a hole')

    sign_in_user
    expect(current_path).to eq projects_path

    create_task

    expect(current_path).to eq projects_path
  end


  scenario "Project show page lists tasks" do
    project = Project.create!(name: 'Dig a hole')

    sign_in_user
    expect(current_path).to eq projects_path

    visit projects_path
    expect(page).to have_content "Projects"

    click_on "Dig a hole"
    expect(page).to have_content "Dig a hole"
    expect(page).to have_content "0 Tasks"

    click_on "0 Tasks"
    expect(page).to have_content "Tasks for Dig a hole"

    click_on "New Task"
    fill_in :task_description, with: "shovel"
    click_on "Create Task"

    expect(page).to have_content "Comments"
end



  scenario "index links to show via the description" do

    project = Project.create!(name: 'Dig a hole')

    sign_in_user
    expect(current_path).to eq projects_path

    visit projects_path
    expect(page).to have_content "Projects"

    click_on "Dig a hole"
    expect(page).to have_content "Dig a hole"
    expect(page).to have_content "0 Tasks"

    click_on "0 Tasks"
    expect(page).to have_content "Tasks for Dig a hole"

    click_on "New Task"
    fill_in :task_description, with: "shovel"
    click_on "Create Task"

    expect(page).to have_content "shovel"
  end

  scenario "can edit task" do


    project = Project.create!(name: 'Dig a hole')

    sign_in_user
    expect(current_path).to eq projects_path

    visit projects_path
    expect(page).to have_content "Projects"

    click_on "Dig a hole"
    expect(page).to have_content "Dig a hole"
    expect(page).to have_content "0 Tasks"

    click_on "0 Tasks"
    expect(page).to have_content "Tasks for Dig a hole"

    click_on "New Task"
    fill_in :task_description, with: "shovel"

    click_on "Create Task"
    expect(page).to have_content "Edit"

    click_on "Edit"

    fill_in :task_description, with: "dirt"
    click_button 'Update Task'

    expect(page).to have_content "Task was successfully updated"
    expect(page).to have_content 'dirt'
  end

end
