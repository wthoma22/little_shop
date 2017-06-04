require 'rails_helper'

RSpec.describe Order do
  it "can find the total of all items in an order" do
    item = create(:item, price: 3)
    item2 = create(:item, price: 4)
    user = create(:user)
    order1 = create(:order, user_id: user.id)
    OrderItem.create(item_id: item.id, order_id: order1.id, quantity: 1)
    OrderItem.create(item_id: item2.id, order_id: order1.id, quantity: 2)

    expect(order1.total).to eq 11
  end
end