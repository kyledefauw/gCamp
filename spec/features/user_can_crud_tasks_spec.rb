require "rails_helper"

  feature "User can Create, Read, Update and Delete Tasks with flash messages" do

    before do
      sign_in
      @project1 = Project.create(:name => 'Killin it')
      @task1 = @project.task.create(:description => 'Do work', :date => '09/06/2021')
    end

    scenario "User can create tasks with flash messages" do
      visit project_tasks_path(@project1)
      click_on 'New Task'
      fill_in 'Description', with: 'Get to work'
      fill_in 'Date', with: '09/06/2021'
      check 'Complete'
      click_on 'Create Task'

      expect(page).to have_content "Get to work"
      expect(page).to have_content "Task was successfully created"
    end

    scenario "User can read tasks with flash messages" do
      visit project_task_path(@task1, @project1)

      expect(page).to have_content 'Do work'
      expect(page).to have_no_content 'Delete'
    end

    scenario "User can update tasks with flash messages" do
      visit project_task_path(@task1, @project1)
      click_on 'Edit'
      fill_in 'Description', with: 'You Better Work'
      click_on 'Update Task'
      expect(page).to have_content('Task was successfully updated')
      expect(page).to have_content('You Better Work')
    end

    scenario "User can delete tasks with flash messages" do
      visit project_tasks_path
      click_on 'Delete'

      expect(page).not_to have_content "Do work"
    end
  end

  feature "User can see at least one validation message displayed" do
    scenario "validation message pops up when no data is filled in" do
      visit new_project_task_path
        fill_in "Date", with: '03/14/2015'
        click_on 'Create Task'
        expect(page).to have_content("Description can't be blank")
    end
  end
