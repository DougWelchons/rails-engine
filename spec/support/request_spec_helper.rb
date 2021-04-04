module RequestRailsHelper

  def json
    info ||= JSON.parse(response.body, symbolize_names: true)
  end

  def create_test_db
    create(:merchant, name: "another one")
    create(:merchant, name: "this other thing")
    create(:merchant, name: "Merchants 4 me")
    create(:merchant, name: "Merchants that do the thing")
    create(:merchant, name: "try again")
    create(:merchant, name: "the merchants for all")
    create(:merchant, name: "the merchants guild")
    create(:merchant, name: "this is a merchant")
    create(:merchant, name: "stand by")
    create(:merchant, name: "one more")
  end
end
