require 'spec_helper.rb'
require 'parser'

RSpec.describe Parser do
  
  APP_ROOT = File.dirname('../')
  Parser.filepath = 'webserver.log'
  let(:parser) {Parser}
  
  it 'checks if file is usable' do
    parser.filepath = 'webserver.log'
    expect(parser.file_usable?).to be(true)
  end
  
  it 'checks if file does not exist' do
    parser.filepath = 'does_not_exist.log'
    expect(parser.file_usable?).to be(false)
  end
  
  it 'return a hash list of url from weblogs' do
    parser.filepath = 'webserver.log'
    logs = parser.parse
    expect(logs).to have_key(:"/about")
    expect(logs).to have_key(:"/home")
    expect(logs).to have_key(:"/help_page/1")
    expect(logs).to have_key(:"/contact")
    expect(logs).to have_key(:"/index")
  end
  
end