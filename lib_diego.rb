def make_paperclip_hash(file_hash)
  hash = {}
  hash['tempfile'] = file_hash[:tempfile]
  hash['filename'] = file_hash[:filename]
  hash['content_type'] = file_hash[:type]
  hash['size'] = file_hash[:tempfile].size
  return hash
end