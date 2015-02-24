require 'rails_helper'

describe "posting a link at the best time", :js, :vcr do
  let(:email) { 'neo@thematrix.com' }
  let(:password) { 'swordfish' }

  def sign_up
    visit '/users/sign_up'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
 end

  before do
    allow(BestTime).to receive(:for_interaction).with('DummyInteraction').and_return(Time.now + 30.minutes)
    sign_up
  end

  it 'does a thing' do
    expect(page).to have_content('successfully')

    click_link 'Account Settings'
    click_link 'Interactions'
    click_link 'New'
    select('Dummy', :from => 'Type')
    check 'Post at best time'
    within('#new_interaction') do
      click_button 'Add'
    end
    expect(page).to have_content('Success!')

    new_interaction = DummyInteraction.last

    expect(new_interaction.post_at_best_time).to eq true
    click_link 'Add'

    fill_in 'Url', with: "http://widdersh.in/the-random-number-gods\t"
    find('#tags input').set 'programming '
    fill_in 'Description', with: 'anything'
    check 'Dummy'
    click_button 'Add'

    expect(page).to have_content('Success!')
    expect(LinkInteraction.last.link.title).to eq "The Random Number Gods - Nick Johnstone's Blog"
  end
end
