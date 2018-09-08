require "sinatra"
require "rest-client"

characters = []


get "/test" do
  characters
end

get "/chars" do
  chars = RestClient.get "https://rickandmortyapi.com/api/character/?page=1"
  data = JSON.parse(chars)
  characters = data["results"].to_json
  characters
end

# make sure I can edit the new post added also

post "/addChar" do
  newArr = JSON.parse(characters)
  newArr.push(params[:char])
  characters = newArr.to_json
end


#fix the name that is being updated to be a string without "\"
# check to see if it works with all ids

put "/editChar" do
  newArr = JSON.parse(characters)
  newArr.each do |key|
    if key["id"] == params[:id].to_i
      key["name"] = params[:name]
    end
  end
  characters = newArr.to_json
end


#fix to delete to delete the object by id not index
# deleting by index breaks because the index shift after an item is deleted
delete "/dltChar" do
  newArr = JSON.parse(characters)
  newArr.slice!(params[:id].to_i - 1)
  characters = newArr.to_json
end

# check JSON 