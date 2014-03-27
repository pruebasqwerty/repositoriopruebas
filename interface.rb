require 'sinatra'
require_relative 'Resources.rb'
require_relative 'lib_diego.rb'

# encoding: utf-8

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

configure do
	
end

get "/" do
  redirect "/home"
end 

get "/home" do
  @title = "Home"
  erb :home
end

get "/newProject" do
  @title = "Create Project"
  erb :newProject
end

post "/newProject" do
  name = params[:name]
  description = params[:description]
  # VALIDATIONS
  project = Project.new(:name => name, :description => description)
  project.save ? @message = ["New project created","success"] : @message = ["Error creating project","danger"]
  erb :home
end

get "/upload" do
  @title = "Uploader"
  erb :upload
end

post "/upload" do
  @title = "Uploader"
  project_id = params[:project].to_i
  puts "PROJ ID #{project_id}"
  if (project_id == 0)
    @message = ["Invalid project","warning"]
    erb :upload
  end
  project = Project.get(project_id)
  puts "PROJ #{project}"
  resource = Resource.new(:file => make_paperclip_hash(params[:file]),:project=>project)
  resource.save ? @message = ["File uploaded successfully","success"] : @message = ["Error uploading file","danger"]
  # @message is [content,type]. Type can be success,info,warning,danger
  erb :upload
end