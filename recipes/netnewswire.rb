unless File.exists?("/Applications/NetNewsWire.app")

  remote_file "#{Chef::Config[:file_cache_path]}/NetNewsWire.zip" do
    source "http://netnewswireapp.com/downloads/NetNewsWire.zip"
    owner WS_USER
  end

  execute "unzip NetNewsWire.app" do
    command "unzip #{Chef::Config[:file_cache_path]}/NetNewsWire.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy SoqlXplorer to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/NetNewsWire.app #{Regexp.escape("/Applications/NetNewsWire.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if NetNewsWire.app was installed" do
    block do
      raise "NetNewsWire.app was not installed" unless File.exists?("/Applications/NetNewsWire.app")
    end
  end

end
