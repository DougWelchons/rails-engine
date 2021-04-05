module RequestRailsHelper

  def json
    info ||= JSON.parse(response.body, symbolize_names: true)
  end

  def seed_test_db
    @merchant1 = create(:merchant, name: "another one")
    @merchant2 = create(:merchant, name: "this other thing")
    @merchant3 = create(:merchant, name: "Merchants 4 me")
    @merchant4 = create(:merchant, name: "Merchants that do the thing")
    @merchant5 = create(:merchant, name: "try again")
    @merchant6 = create(:merchant, name: "the merchants for all")
    @merchant7 = create(:merchant, name: "the merchants guild")
    @merchant8 = create(:merchant, name: "this is a merchant")
    @merchant9 = create(:merchant, name: "stand by")
    @merchant10 = create(:merchant, name: "one more")

    @item1 = create(:item, unit_price: 1, merchant: @merchant1, name: "Item 1")
    @item2 = create(:item, unit_price: 1, merchant: @merchant1, name: "Item 2")
    @item3 = create(:item, unit_price: 1, merchant: @merchant2, name: "Item 3")
    @item4 = create(:item, unit_price: 1, merchant: @merchant3, name: "Item 4")
    @item5 = create(:item, unit_price: 1, merchant: @merchant3, name: "Item 5")
    @item6 = create(:item, unit_price: 1, merchant: @merchant4, name: "Item 6")
    @item7 = create(:item, unit_price: 1, merchant: @merchant5, name: "Item 7")
    @item8 = create(:item, unit_price: 1, merchant: @merchant6, name: "Item 8")
    @item9 = create(:item, unit_price: 1, merchant: @merchant7, name: "Item 9")
    @item10 = create(:item, unit_price: 1, merchant: @merchant7, name: "Item 10")
    @item11 = create(:item, unit_price: 1, merchant: @merchant9, name: "Item 11")
    @item12 = create(:item, unit_price: 1, merchant: @merchant10, name: "Item 12")
    @item13 = create(:item, unit_price: 1, merchant: @merchant7, name: "Item 13")
    @item14 = create(:item, unit_price: 1, merchant: @merchant7, name: "Item 14")
    @item15 = create(:item, unit_price: 1, merchant: @merchant8, name: "Item 15")
    @item16 = create(:item, unit_price: 1, merchant: @merchant10, name: "Item 16")
    @item17 = create(:item, unit_price: 1, merchant: @merchant5, name: "Item 17")
    @item18 = create(:item, unit_price: 1, merchant: @merchant5, name: "Item 18")

    @customer = create(:customer)

    @invoice1 = create(:invoice, customer: @customer, merchant: @merchant10)
    @invoice2 = create(:invoice, customer: @customer, merchant: @merchant7)
    @invoice3 = create(:invoice, customer: @customer, merchant: @merchant3, status: "packaged")
    @invoice4 = create(:invoice, customer: @customer, merchant: @merchant5)
    @invoice5 = create(:invoice, customer: @customer, merchant: @merchant9)
    @invoice6 = create(:invoice, customer: @customer, merchant: @merchant4, status: "packaged")
    @invoice7 = create(:invoice, customer: @customer, merchant: @merchant4, status: "packaged")
    @invoice8 = create(:invoice, customer: @customer, merchant: @merchant6, status: "returned")
    @invoice9 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")
    @invoice10 = create(:invoice, customer: @customer, merchant: @merchant10)
    @invoice11 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")
    @invoice12 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")
    @invoice13 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")
    @invoice14 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")
    @invoice15 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")
    @invoice16 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")
    @invoice17 = create(:invoice, customer: @customer, merchant: @merchant10, status: "packaged")

    create(:transaction, invoice: @invoice1, result: "failed")
    create(:transaction, invoice: @invoice1)
    create(:transaction, invoice: @invoice2)
    create(:transaction, invoice: @invoice3)
    create(:transaction, invoice: @invoice4)
    create(:transaction, invoice: @invoice5)
    create(:transaction, invoice: @invoice6, result: "failed")
    create(:transaction, invoice: @invoice7, result: "failed")
    create(:transaction, invoice: @invoice8, result: "failed")
    create(:transaction, invoice: @invoice8)
    create(:transaction, invoice: @invoice9, result: "failed")
    create(:transaction, invoice: @invoice10, result: "failed")
    create(:transaction, invoice: @invoice10, result: "failed")
    create(:transaction, invoice: @invoice10)

    create(:invoice_item, invoice: @invoice1, item: @item12, unit_price: 1.81, quantity: 100)
    create(:invoice_item, invoice: @invoice1, item: @item16, unit_price: 2.35, quantity: 12)
    create(:invoice_item, invoice: @invoice2, item: @item10, unit_price: 10.90, quantity: 56)
    create(:invoice_item, invoice: @invoice3, item: @item4, unit_price: 12.00, quantity: 24)
    create(:invoice_item, invoice: @invoice3, item: @item5, unit_price: 114.50, quantity: 14)
    create(:invoice_item, invoice: @invoice4, item: @item7, unit_price: 12.50, quantity: 125)
    create(:invoice_item, invoice: @invoice4, item: @item17, unit_price: 21.91, quantity: 35)
    create(:invoice_item, invoice: @invoice4, item: @item18, unit_price: 45, quantity: 190)
    create(:invoice_item, invoice: @invoice5, item: @item11, unit_price: 100, quantity: 114)
    create(:invoice_item, invoice: @invoice6, item: @item6, unit_price: 134, quantity: 155)
    create(:invoice_item, invoice: @invoice7, item: @item6, unit_price: 19.45, quantity: 55)
    create(:invoice_item, invoice: @invoice8, item: @item8, unit_price: 20.11, quantity: 50)
    create(:invoice_item, invoice: @invoice9, item: @item12, unit_price: 1, quantity: 101)
    create(:invoice_item, invoice: @invoice10, item: @item12, unit_price: 0.90, quantity: 178)
    create(:invoice_item, invoice: @invoice10, item: @item16, unit_price: 0.09, quantity: 45)
    create(:invoice_item, invoice: @invoice11, item: @item16, unit_price: 1.50, quantity: 257)
    create(:invoice_item, invoice: @invoice12, item: @item16, unit_price: 50.00, quantity: 20)
    create(:invoice_item, invoice: @invoice13, item: @item16, unit_price: 45, quantity: 45)
    create(:invoice_item, invoice: @invoice14, item: @item16, unit_price: 5, quantity: 24)
    create(:invoice_item, invoice: @invoice15, item: @item16, unit_price: 8.91, quantity: 19)
    create(:invoice_item, invoice: @invoice16, item: @item16, unit_price: 250, quantity: 6)
    create(:invoice_item, invoice: @invoice17, item: @item16, unit_price: 89.02, quantity: 50)
  end
end
