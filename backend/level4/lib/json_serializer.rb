require 'json'

class JsonSerializer
  def read(filename)
    file = File.read(filename)
    return JSON.load(file)
  end

  def write(filename, data)
    content = JSON.pretty_generate(data)
    File.write(filename, content)
  end
end
