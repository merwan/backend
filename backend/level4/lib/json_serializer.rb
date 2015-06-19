require 'json'

class JsonSerializer
  def read(filename)
    file = File.read(filename)
    return JSON.load(file)
  end
end
