title 'Packages'

control 'Packages' do
  title 'Check if necessary packages are installed'
  describe package('yamllint') do
    it { should be_installed }
  end

  describe package('jq') do
    it { should be_installed }
  end

  unless os.redhat?
    describe package('direnv') do
      it { should be_installed }
    end
  end
end
