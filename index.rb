require "sinatra"
require "rest-client"

characters = []


get "/test" do
  characters.to_json
end

get "/chars" do
  chars = RestClient.get "https://rickandmortyapi.com/api/character/?page=1"
  data = JSON.parse(chars)
  characters = data["results"].to_json
  characters
end

#add id to new post
# make sure I can edit the new post added also

post "/addChar" do
  char = params[:char]
  newArr = JSON.parse(characters)
  newArr.push(char)
  newArr.to_json
end


#fix the name that is being updated to be a string without "\"
# check to see if it works with all ids

put "/editChar" do
  newArr = JSON.parse(characters)
  newArr.each do |key|
    if key["id"] == params[:id].to_i
      key["name"] = params[:name].to_s
    end
  end
  characters = newArr.to_json
end

# make delete endpoint