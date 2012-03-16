# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').collect{|r| "ratings_" + r.strip}.each{|rating|
    if uncheck then uncheck(rating) else check(rating) end
  }
end

Then /I should see (.*) of the movies/ do |all_or_none|
  if all_or_none == "all"
    # check the tr tags in the only table on the page and compare
    # against count of database records
    page.has_css?("tbody tr", :count => Movie.all.count)
  elsif all_or_none == "none"
    # check that the table contains no tr rows at all
    not page.has_css?("tbdoy tr")
  else
    assert false, "Unimplemented"
  end
end
