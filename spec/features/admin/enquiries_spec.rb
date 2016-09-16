require 'rails_helper'

feature 'Admin enquiries' do
  background { login_as(create(:administrator).user) }

  scenario 'Index' do
    e1 = create(:enquiry)
    e2 = create(:enquiry)

    visit admin_enquiries_path

    expect(page).to have_content(e1.title)
    expect(page).to have_content(e2.title)
  end

  scenario 'Destroy' do
    e1 = create(:enquiry)
    e2 = create(:enquiry)

    visit admin_enquiries_path

    within("#enquiry_#{e1.id}") do
      click_link "Delete"
    end

    expect(page).to_not have_content(e1.title)
    expect(page).to have_content(e2.title)
  end

  scenario 'Update' do
    e1 = create(:enquiry)
    visit admin_enquiries_path
    within("#enquiry_#{e1.id}") do
      click_link "Edit"
    end

    old_title = e1.title
    new_title = "Potatoes are great and everyone should have one"
    fill_in 'enquiry_title', with: new_title

    click_button 'Save'

    expect(page).to have_content "Changes saved"
    expect(page).to have_content new_title

    visit admin_enquiries_path

    expect(page).to have_content(new_title)
    expect(page).to_not have_content(old_title)
  end

  scenario 'Create' do
    title = "Star Wars: Episode IV - A New Hope"
    summary = "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire"
    description = %{
      During the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the DEATH STAR, an armored space station with enough power to destroy an entire planet.
      Pursued by the Empire's sinister agents, Princess Leia races home aboard her starship, custodian of the stolen plans that can save her people and restore freedom to the galaxy....
    }
    question = "Aren't you a little short for a stormtrooper?"

    visit admin_enquiries_path
    click_link "Create new"

    fill_in 'enquiry_title', with: title
    fill_in 'enquiry_summary', with: summary
    fill_in 'enquiry_description', with: description
    fill_in 'enquiry_question', with: question

    click_button 'Save'

    expect(page).to have_content(title)
    expect(page).to have_content(description)
    expect(page).to have_content(summary)
    expect(page).to have_content(question)
  end

end