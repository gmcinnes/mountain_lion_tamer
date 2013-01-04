unless File.exists?("/Applications/SoqlXplorer.app")

  remote_file "#{Chef::Config[:file_cache_path]}/soqlXplorer_v1.91.zip" do
    source "http://www.pocketsoap.com/osx/soqlx/soqlXplorer_v1.91.zip"
    owner WS_USER
  end

  execute "unzip SoqlXplorer.app" do
    command "unzip #{Chef::Config[:file_cache_path]}/soqlXplorer_v1.91.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy SoqlXplorer to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/SoqlXplorer.app #{Regexp.escape("/Applications/SoqlXplorer.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if SoqlXplorer.app was installed" do
    block do
      raise "SoqlXplorer.app was not installed" unless File.exists?("/Applications/SoqlXplorer.app")
    end
  end

end
