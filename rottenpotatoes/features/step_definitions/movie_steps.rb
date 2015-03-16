# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(title: movie["title"],rating: movie["rating"],release_date: movie["release_date"])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" visible/ do |e1|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "failed" unless page.body.include?("<td>#{e1}</td>")
end

Then /I should not see "(.*)" visible/ do |e1|
  flunk "failed" if page.body.include?("<td>#{e1}</td>")
end 

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |element|
    if uncheck.nil?
      check("ratings_#{element}")
    else
      uncheck("ratings_#{element}")
    end
  end
  # flunk "Unimplemented"
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  ["G","R","PG-13","PG"].each do |element|
    flunk "failed" unless page.body.include?("<td>#{element}</td>")
  end
end
