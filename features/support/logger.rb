module LoggerHelper
  def dump(contents)
    in_tmp_folder do
      File.open("dump_file.txt", "w") do |file|
        file << contents
      end
      unless ENV['CUCUMBER_EDITOR']
        puts contents
      else
        `#{ENV['CUCUMBER_EDITOR']} '#{File.expand_path filename}'`
      end
    end
  end
  
end

World(LoggerHelper)