require 'rails_helper'

RSpec.describe "visitor can add items and remove from the cart" do
  scenario "they can click a link to add item to cart" do
    category = create(:category, name: "Surf")
    item1 = create(:item, title: "Wetsuit", category: category)
    category2 = create(:category, name: "Surf")
    item2 = create(:item, title: "Wetsuit", category: category2)

    visit category_path(category)

    expect(page).to have_content(item1.title)
    expect(page).to have_link("Add to Cart")

    click_on("Add to Cart")

    visit category_path(category2)

    click_on("Add to Cart")

    expect(current_path).to eq(category_path(category2))

    click_on("View Cart")

    expect(current_path).to eq("/cart")
    expect(page).to have_css("img[src=\"#{item1.image}\"]")
    expect(page).to have_content(item1.title)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.price)
    expect(page).to have_content(item2.title)
    expect(page).to have_content(item2.description)
    expect(page).to have_content(item2.price)
    expect(page).to have_content("Total: #{item1.price + item2.price}")
  end

  scenario "visitor starts with an item and removes" do
    category = create(:category, name: "Surf")
    item1 = create(:item, title: "Wetsuit", category: category)

    visit category_path(category)

    expect(page).to have_content(item1.title)
    expect(page).to have_link("Add to Cart")

    click_on("Add to Cart")

    click_on("View Cart")

    expect(current_path).to eq("/cart")

    click_on("Remove")

    expect(current_path).to eq("/cart")
    expect(flash[:notice]).to have_css(".add_to_cart") # Double check
    expect(page).to have_content("Successfully removed #{item1.title} from your cart.")
    expect(page).to have_link(item_path(item1))
    expect(page).to_not have_css('h3', item1.title)

  end
end