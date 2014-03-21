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

get "/upload" do
  @title = "Uploader"
  erb :upload
end

post "/upload" do
  resource = Resource.new(:file => make_paperclip_hash(params[:file]))
  resource.save ? @message = ["File uploaded successfully","success"] : @message = ["Error uploading file","danger"]
  # @message is [content,type]. Type can be success,info,warning,danger
  @title = "Uploader"
  erb :upload
end