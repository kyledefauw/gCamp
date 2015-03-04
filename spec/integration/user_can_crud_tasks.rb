require "rails_helper"

  feature "User can Create, Read, Update and Delete Tasks with flash messages"  do
    scenario "User can create tasks with flash messages" do
      visit('/tasks')
      click_botton('New Task')
      fill_in('Description', with: 'Get to work')
      fill_in('Date', with: '09/06/1991')
      check('Complete')

      expect(page).to_have ("Get to work")
      expect(page).to_have ("Task was successfully created")
    end

    scenario "User can read tasks with flash messages" do
      visit('task_path(task)')

    end

    scenario "User can update tasks with flash messages" do
      visit('/tasks')
      click_botton('Edit')

      expect(page).to_have ("Task was successfully updated")
    end

    scenario "User can delete tasks with flash messages" do
      visit('/tasks')
      click_botton('New Task')
      fill_in('Description', with: 'Get to work')
      fill_in('Date', with: '09/06/2091')
      check('Complete')

      click_botton("Delete")

      expect(page).not_to_have ("Get to work")
      expect(page).not_to_have ("2091-09-06")
      expect(page).to_have ("Task was successfully deleted")
    end

  feature "User can see at least one validation message displayed" do
    scenario "validation message pops up when no data is filled in" do
      visit('/tasks')
      click_botton('New Task')
      fill_in('Description', with: '')

      expect(page).to have_content('prohibited this form from being saved')
    end
  end

  feature "Model testing - Tasks are not valid without a description" do
    scenario "fill in task without a description" do

    end
  end

end
