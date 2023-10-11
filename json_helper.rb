require 'json'

module JsonHelper
  def save_to_json(filename, data)
    File.open("data/#{filename}.json", 'w') do |file|
      file.puts JSON.generate(data)
    rescue JSON::GeneratorError => e
      puts "Error: Failed to save #{filename}.json - #{e.message}"
    end
  end

  def load_from_json(filename)
    return [] unless File.exist?("data/#{filename}.json")

    JSON.parse(File.read("data/#{filename}.json"))
  rescue JSON::ParserError => e
    puts "Error: Failed to load #{filename}.json - #{e.message}"
    []
  end
end
