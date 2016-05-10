require 'spec_helper'

describe 'c_icap', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :id                     => 'root',
        :kernel                 => 'Linux',
        :lsbdistcodename        => 'jessie',
        :osfamily               => 'Debian',
        :operatingsystem        => 'Debian',
        :operatingsystemrelease => '8',
        :path                   => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        :concat_basedir         => '/dne',
        :is_pe                  => false,
      }
    end

    describe 'Test standard installation' do
      it { should contain_package('c-icap').with_ensure('present') }
      it { should contain_service('c-icap').with_ensure('running') }
      it { should contain_service('c-icap').with_enable('true') }
      it { should contain_file('c-icap.conf').with_ensure('present') }
    end

    describe 'Test installation of a specific version' do
      let(:params) { {:version => '1.0.42' } }
      it { should contain_package('c-icap').with_ensure('1.0.42') }
    end

    describe 'Test standard installation with monitoring and firewalling' do
      let(:params) { {:monitor => true , :firewall => true, :port => '42', :protocol => 'tcp' } }
      it { should contain_package('c-icap').with_ensure('present') }
      it { should contain_service('c-icap').with_ensure('running') }
      it { should contain_service('c-icap').with_enable('true') }
      it { should contain_file('c-icap.conf').with_ensure('present') }
      it { should contain_monitor__process('c_icap_process').with_enable('true') }
      it { should contain_firewall('c_icap_tcp_42').with_enable('true') }
    end

    describe 'Test decommissioning - absent' do
      let(:params) { {:absent => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
      it 'should remove Package[c-icap]' do should contain_package('c-icap').with_ensure('absent') end
      it 'should stop Service[c-icap]' do should contain_service('c-icap').with_ensure('stopped') end
      it 'should not enable at boot Service[c-icap]' do should contain_service('c-icap').with_enable('false') end
      it 'should remove c_icap configuration file' do should contain_file('c-icap.conf').with_ensure('absent') end
      it { should contain_monitor__process('c_icap_process').with_enable('false') }
      it { should contain_firewall('c_icap_tcp_42').with_enable('false') }
    end

    describe 'Test decommissioning - disable' do
      let(:params) { {:disable => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
      it { should contain_package('c-icap').with_ensure('present') }
      it 'should stop Service[c-icap]' do should contain_service('c-icap').with_ensure('stopped') end
      it 'should not enable at boot Service[c-icap]' do should contain_service('c-icap').with_enable('false') end
      it { should contain_file('c-icap.conf').with_ensure('present') }
      it { should contain_monitor__process('c_icap_process').with_enable('false') }
      it { should contain_firewall('c_icap_tcp_42').with_enable('false') }
    end

    describe 'Test decommissioning - disableboot' do
      let(:params) { {:disableboot => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
      it { should contain_package('c-icap').with_ensure('present') }
      it { should_not contain_service('c-icap').with_ensure('present') }
      it { should_not contain_service('c-icap').with_ensure('absent') }
      it 'should not enable at boot Service[c-icap]' do should contain_service('c-icap').with_enable('false') end
      it { should contain_file('c-icap.conf').with_ensure('present') }
      it { should contain_monitor__process('c_icap_process').with_enable('false') }
      it { should contain_firewall('c_icap_tcp_42').with_enable('true') }
    end

    describe 'Test customizations - template' do
      let(:params) { {:template => "c_icap/spec.erb" , :options => { 'opt_a' => 'value_a' } } }
      it 'should generate a valid template' do
        content = catalogue.resource('file', 'c-icap.conf').send(:parameters)[:content]
        content.should match "fqdn: rspec.example42.com"
      end
      it 'should generate a template that uses custom options' do
        content = catalogue.resource('file', 'c-icap.conf').send(:parameters)[:content]
        content.should match "value_a"
      end
    end

    describe 'Test customizations - source' do
      let(:params) { {:source => "puppet:///modules/c_icap/spec"} }
      it { should contain_file('c-icap.conf').with_source('puppet:///modules/c_icap/spec') }
    end

    describe 'Test customizations - source_dir' do
      let(:params) { {:source_dir => "puppet:///modules/c_icap/dir/spec" , :source_dir_purge => true } }
      it { should contain_file('c-icap.dir').with_source('puppet:///modules/c_icap/dir/spec') }
      it { should contain_file('c-icap.dir').with_purge('true') }
      it { should contain_file('c-icap.dir').with_force('true') }
    end

    describe 'Test customizations - custom class' do
      let(:params) { {:my_class => "c_icap::spec" } }
      it { should contain_file('c-icap.conf').with_content(/rspec.example42.com/) }
    end

    describe 'Test service autorestart' do
      let(:params) { {:service_autorestart => "no" } }
      it 'should not automatically restart the service, when service_autorestart => false' do
        content = catalogue.resource('file', 'c-icap.conf').send(:parameters)[:notify]
        content.should be_nil
      end
    end

    describe 'Test Puppi Integration' do
      let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }
      it { should contain_puppi__ze('c_icap').with_helper('myhelper') }
    end

    describe 'Test Monitoring Tools Integration' do
      let(:params) { {:monitor => true, :monitor_tool => "puppi" } }
      it { should contain_monitor__process('c_icap_process').with_tool('puppi') }
    end

    describe 'Test Firewall Tools Integration' do
      let(:params) { {:firewall => true, :firewall_tool => "iptables" , :protocol => "tcp" , :port => "42" } }
      it { should contain_firewall('c_icap_tcp_42').with_tool('iptables') }
    end

    describe 'Test OldGen Module Set Integration' do
      let(:params) { {:monitor => "yes" , :monitor_tool => "puppi" , :firewall => "yes" , :firewall_tool => "iptables" , :puppi => "yes" , :port => "42" , :protocol => 'tcp' } }
      it { should contain_monitor__process('c_icap_process').with_tool('puppi') }
      it { should contain_firewall('c_icap_tcp_42').with_tool('iptables') }
      it { should contain_puppi__ze('c_icap').with_ensure('present') }
    end

    describe 'Test params lookup' do
      let(:facts) { { :monitor => true , :ipaddress => '10.42.42.42' } }
      let(:params) { { :port => '42' } }
      it 'should honour top scope global vars' do should contain_monitor__process('c_icap_process').with_enable('true') end
    end

    describe 'Test params lookup' do
      let(:facts) { { :c_icap_monitor => true , :ipaddress => '10.42.42.42' } }
      let(:params) { { :port => '42' } }
      it 'should honour module specific vars' do should contain_monitor__process('c_icap_process').with_enable('true') end
    end

    describe 'Test params lookup' do
      let(:facts) { { :monitor => false , :c_icap_monitor => true , :ipaddress => '10.42.42.42' } }
      let(:params) { { :port => '42' } }
      it 'should honour top scope module specific over global vars' do should contain_monitor__process('c_icap_process').with_enable('true') end
    end

    describe 'Test params lookup' do
      let(:facts) { { :monitor => false , :ipaddress => '10.42.42.42' } }
      let(:params) { { :monitor => true , :firewall => true, :port => '42' } }
      it 'should honour passed params over global vars' do should contain_monitor__process('c_icap_process').with_enable('true') end
    end

  end

end
