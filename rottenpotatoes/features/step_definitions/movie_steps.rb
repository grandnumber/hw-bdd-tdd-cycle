Given(/^the following movies exist:$/) do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |movie, director|
     page.should have_content(movie)
     page.should have_content(director)
end

Then("Find Movies With Same Director") do
end 
