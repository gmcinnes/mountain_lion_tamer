unless File.exists?("/Applications/CoRD.app")

  remote_file "#{Chef::Config[:file_cache_path]}/CoRD.app" do
    source "http://downloads.sourceforge.net/project/cord/cord/0.5.7/CoRD_0.5.7.zip?r=http%3A%2F%2Fcord.sourceforge.net%2F&ts=1357267533&use_mirror=superb-dca2"
    owner WS_USER
  end

  execute "unzip CoRD.app" do
    command "unzip #{Chef::Config[:file_cache_path]}/CoRD.app -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy CoRD to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/CoRD.app #{Regexp.escape("/Applications/CoRD.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if CoRD.app was installed" do
    block do
      raise "CoRD.app was not installed" unless File.exists?("/Applications/CoRD.app")
    end
  end

end
