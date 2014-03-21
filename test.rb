require 'sinatra'
require 'data_mapper'
require 'dm-paperclip'
require 'haml'
 
DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/test.db")

class Resource
  include DataMapper::Resource
  include Paperclip::Resource
 
  property :id,     Serial
 
  has_attached_file :file,
                    :url => "/:attachment/:id/:style/:basename.:extension",
                    :path => "#{Dir.pwd}/public/:attachment/:id/:style/:basename.:extension"
end
 
Resource.auto_migrate!
 
def make_paperclip_hash(file_hash)
  hash = {}
  hash['tempfile'] = file_hash[:tempfile]
  hash['filename'] = file_hash[:filename]
  hash['content_type'] = file_hash[:type]
  hash['size'] = file_hash[:tempfile].size
  hash
end
 
post '/upload' do
  halt 409, "File seems to be emtpy" unless params[:file][:tempfile].size > 0
  @resource = Resource.new(:file => make_paperclip_hash(params[:file]))
  halt 409, "There were some errors processing your request...\n#{resource.errors.inspect}" unless @resource.save
 
  haml :upload
end
 
get '/' do
  haml :index
end
 
__END__
@@ index
%form{:action => '/upload', :enctype => 'multipart/form-data', :method => 'POST'}
  %input{:type => 'file', :name => 'file'}
  %input{:type => 'submit'}
 
@@ upload
%p= "Congrats! This is your #{@resource.file.name} uploaded file!"
%img{:src => @resource.file.url }