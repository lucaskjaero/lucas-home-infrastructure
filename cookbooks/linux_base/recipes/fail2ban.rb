package "fail2ban"

cookbook_file "/etc/fail2ban/jail.local" do
    source "jail.local"
    owner "root"
    group "root"
    mode "0755"
  end