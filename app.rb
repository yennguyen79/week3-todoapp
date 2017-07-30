require 'bundler/setup'
Bundler.require

require_relative "list"

def debug_params
  puts "PARAMS: #{params}"
end

get "/" do
  @title = "ToDo App"
  path_arr = Dir["./data/*.md"]
  id_arr = path_arr.map do |path|
    path.split("/").last.to_i
  end
  lists = id_arr.map do |id|
    list = List.new(id)
    list.load_from_file
    list
  end
   erb :"index.html", locals: {lists: lists}, layout: :"layout.html"
end


post "/lists/update" do
  debug_params

  list = List.new(params["id"])
  list.name = params["name"]
  items = params["items"].map do |item_hash|
    puts "creating Item from item_hash: #{item_hash}"
    Item.new(item_hash["name"], item_hash["status"])
  end
  list.items = items

  if params["toggle"]
    puts "Toggle: #{params["toggle"]}"
    list.toggle_item(params["toggle"])
  end

  list.save!
  redirect back
end

post "/lists/:id/items/add" do
  debug_params

  list = List.new(params["id"])
  list.load_from_file
  puts "Creating item #{params['name']} for list #{params['id']}"
  if params["name"]
    list.add(params["name"])
    list.save!
  end
  redirect back
end

post '/add-list' do
  debug_params
  new_list = List.new(params["new_file_number"])
  new_list.name = params["item_name"]
  new_list.save!
  redirect back
end