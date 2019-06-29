module ImportHelper

  def prepare_sample_csv_file(collection, data_type)
    filename = SecureRandom.hex(8).downcase
    data_string = "#{data_type.to_s.capitalize}::Export".constantize.call(collection)
    File.open("spec/fixtures/#{filename}.csv", "w+") { |file| file.write(data_string) }
    Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/#{filename}.csv"))
  end
end
