require "rails_helper"

  feature "User can Create, Read, Update and Delete projects with flash messages"  do
    scenario "User can create projects with flash messages" do
      visit('/projects')
      click_botton('New Project')
      fill_in('Description', with: 'Get to work')
      fill_in('Date', with: '09/06/1991')
      check('Complete')
    end

    scenario "User can read projects with flash messages" do
      visit('project_path(project)')

    end

    scenario "User can update projects with flash messages" do
      visit('/projects')
      click_botton('Edit')

    end

    scenario "User can delete projects with flash messages" do
      visit('/projects')
      click_botton('Delete')

    end

  feature "User can see at least one validation message displayed" do
    scenario "validation message pops up when no data is filled in" do
      visit('/projects')
      click_botton('Edit')

    end
  end

  feature "Model testing - projects are not valid without a description" do
    scenario "fill in project without a description" do

    end
  end

end
