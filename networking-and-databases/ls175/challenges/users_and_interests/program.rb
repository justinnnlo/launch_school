require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @file = File.read("/data/users.yaml")
  @data = Psych.load(@file)
end

helpers do
  def count_interests
    @data.values.each_with_object([]) { |h, o| o << h[:interests] }.flatten.uniq.count
  end
end

get "/" do
  erb :home
end

get "/:name" do
  others = @data.select { |k| k != params[:name].to_sym }
  erb :users
end

not_found do
  "<h1>404 Not Found</h1>"
end