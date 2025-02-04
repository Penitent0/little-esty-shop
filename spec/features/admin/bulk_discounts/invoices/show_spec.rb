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
      
      within "#total-revenue" do
        expect(page).to have_content((invoice_1.total_revenue.round/100.00).to_s(:delimited))
      end

      visit admin_invoice_path(invoice_2)

      within "#total-revenue" do
        expect(page).to have_content((invoice_2.total_revenue.round/100.00).to_s(:delimited))
      end
    end

    it 'And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation' do
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

      bulk_discount_1 = create(:bulk_discount, merchant: merchant_1, discount: 0.25, threshold: 10)
      bulk_discount_2 = create(:bulk_discount, merchant: merchant_2, discount: 0.10, threshold: 5)

      visit admin_invoice_path(invoice_1)
      
      within "#total-discounted-revenue" do
        expect(page).to have_content((invoice_1.total_discounted_revenue.round/100.00).to_s(:delimited))
      end

      visit admin_invoice_path(invoice_2)
      
      within "#total-discounted-revenue" do
        expect(page).to have_content((invoice_2.total_discounted_revenue.round/100.00).to_s(:delimited))
      end
    end
  end
end