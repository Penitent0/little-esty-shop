require 'rails_helper'

RSpec.describe 'admin invoice show page bulk discounts' do 

  # As an admin
  # When I visit an admin invoice show page
  # Then I see the total revenue from this invoice (not including discounts)
  # And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
  
  describe 'User Story 8 - As an admin When I visit an admin invoice show page' do
    it 'Then I see the total revenue from this invoice (not including discounts)' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_1)
      item_3 = create(:item, merchant: merchant_1)

      item_4 = create(:item, merchant: merchant_2)
      item_5 = create(:item, merchant: merchant_2)
      item_6 = create(:item, merchant: merchant_2)

      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      create(:invoice_items, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 10) # 1000
      create(:invoice_items, invoice_id: invoice_1.id, item_id: item_2.id, unit_price: 200, quantity: 20) # 4000
      create(:invoice_items, invoice_id: invoice_1.id, item_id: item_3.id, unit_price: 150, quantity: 5) # 750

      create(:invoice_items, invoice_id: invoice_2.id, item_id: item_4.id, unit_price: 50, quantity: 5) # 250
      create(:invoice_items, invoice_id: invoice_2.id, item_id: item_5.id, unit_price: 75, quantity: 15) # 1125
      create(:invoice_items, invoice_id: invoice_2.id, item_id: item_6.id, unit_price: 15, quantity: 10) # 150

      visit admin_invoice_path(invoice_1)

      expect(invoice_1.total_revenue).to eq()
    end

    it 'And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation' do

    end
  end
end