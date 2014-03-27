MAIL_FORMAT = /[a-z0-9._%+-]*@[a-z0-9.-]*\.[a-z]{2,4}/
INTEGER_FORMAT = /[0-9]{1,32}/

def make_paperclip_hash(file_hash)
  hash = {}
  hash['tempfile'] = file_hash[:tempfile]
  hash['filename'] = file_hash[:filename]
  hash['content_type'] = file_hash[:type]
  hash['size'] = file_hash[:tempfile].size
  return hash
end

# Validates different types based on regexp and such
# @return true if validation succeeds, false if not
def validate(type,input)
  if input.nil? then return false end
  if !(input.is_a? String) then return false end
  case type
    when 'Integer'
      return !(input.match(INTEGER_FORMAT).nil?)
    when 'String'
      return (input.length <= 1024)
    when 'Mail'
      return !(input.match(MAIL_FORMAT).nil?)
  end
end