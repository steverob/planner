require 'spec_helper'

feature 'a member sign up', pending: "Need to test with github redirect" do
  before do
    [ "Student", "Coach", "Mentor", "Admin" ].each { |role| Role.create name: role }
  end

  let(:member) { Fabricate(:member) }
  let(:name) { Faker::Name.first_name }

  scenario 'when they fill in all the required details' do
    fill_in_member_details name
    click_on "Join Codebar.io"

    page.should have_content "Thanks for signing up #{name}! #{I18n.t("messages.no_roles")}"
  end

  context "a member can sign up" do
    scenario 'as a Student' do
      log_in_member member

      visit "/member/edit"
      fill_in_member_details name

      check "Student"

      click_on "Join Codebar.io"

      page.should have_content "Thanks for signing up #{name}! You will be receiving notifications for: Students"
    end

    scenario 'as a Coach' do
      fill_in_member_details "Maria"
      check "Coach"

      click_on "Join Codebar.io"

      page.should have_content "Thanks for signing up Maria! You will be receiving notifications for: Coaches"
    end
  end
end
