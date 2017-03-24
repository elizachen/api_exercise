namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => {:key => "d0743cb7587106c10430d6329c2341b7" }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id( c["juhe_id"])
      if existing_city.nil?
        City.create!(:juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"])
      end
    end

    puts "Total: #(City.count) cities"
    end
end
