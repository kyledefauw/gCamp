require "rails_helper"

  feature "User can Create, Read, Update and Delete projects with flash messages" do

    before do
      @project1 = Project.create(:name => 'Killin it')
    end

    scenario "User can create projects with flash messages" do
      visit projects_path
      click_on 'New Project'
      fill_in 'Name', with: 'Killin it'
      click_on 'Create Project'

      expect(page).to have_content "Killin it"
      expect(page).to have_content "Project was successfully created"
    end

    scenario "User can read projects with flash messages" do
      visit project_path(@project1)

      expect(page).to have_content 'Killin it'
    end

    scenario "User can update projects with flash messages" do
      visit project_path(@project1)
      click_on 'Edit'
      fill_in 'Name', with: 'Killin it'
      click_on 'Update Project'
      expect(page).to have_content('Project was successfully updated')
      expect(page).to have_content('Killin it')
    end

    scenario "User can delete projects with flash messages" do
      visit project_path(@project1)
      click_on 'Delete'

      expect(page).not_to have_content "Killin it"
    end
  end

  feature "User can see at least one validation message displayed" do
    scenario "validation message pops up when no data is filled in" do
      visit new_project_path
        fill_in "Name", with: ''
        click_on 'Create Project'
        expect(page).to have_content("Name can't be blank")
    end
  end
