require 'rails_helper'

RSpec.describe "An unauthenticated user" do
  it "cannot view another user's private data" do
    user = create(:user)

    visit items_path
    expect(page).to_not have_link("My Account", href: '/dashboard')
    expect(page).to_not have_content user.username
    # we should probably test to make sure that if they type in the address that they get the 404 message, but...
    # expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "must login or create an account to checkout" do
    item = create(:item)
    user = create(:user)

    visit items_path
    click_on "Add to Cart"
    click_on "View Cart"

    expect(page).to have_content item.title
    expect(page).to have_content item.price

    click_on "Checkout"

    expect(page).to have_content "You must login to checkout"
    expect(page).to have_content "Login"
    expect(page).to have_content "Create Account"

    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_content user.username
    click_link "Cart"

    expect(page).to have_content item.name
    expect(page).to have_content item.price
    expect(page).to has_css('img', "") ####fix this with an image source
  end

  # it "cannot view the administrator screens" do
  #   visit '/admin/dashboard'
  #   expect(page).to_not have_content "Admin Dashboard"
  #   expect(page).to have_content "The page you were looking for doesn't exist."
  # end
  #
  # it "cannot make themselves an administrator" do
  #
  # end
end
