require 'spec_helper.rb'
require 'guide.rb'
require 'config'

RSpec.describe Guide do
  
  let(:guide) {Guide.new('webserver.log')}
  
  context 'when launched' do
    it 'displays introduction' do
      expect(guide.methods.grep(/introduction/)).to match_array([:introduction])
    end
    it 'displays conclusion' do
      expect(guide.methods.grep(/conclusion/)).to match_array([:conclusion])
    end
    it 'displays output header' do
      expect(guide.methods.grep(/output_action_header/)).to match_array([:output_action_header])
    end
    it 'allows only permitted user actions' do
      expect(Config.actions).to include('logs')
      expect(Config.actions).to include('quit')
      expect(Config.actions).not_to include('index')
    end
  end
  
end