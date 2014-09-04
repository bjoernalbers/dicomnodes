require 'spec_helper'

describe 'Imports' do
  let(:nodelist_dir) { Rails.root.join('spec', 'support', 'assets') }
  let(:default_nodelist) { nodelist_dir.join('default.plist') }
  let(:import_nodelist) { nodelist_dir.join('import.plist') }

  def reset_nodelist
    FileUtils.cp(default_nodelist, Rails.root.join('public', 'DICOMNodes.plist'))
  end

  before do
    reset_nodelist
  end

  it 'returns a default nodelist' do
    get '/DICOMNodes.plist'
    expect(response.status).to eq(200)
    expect(response.body).to eq(File.read(default_nodelist))
  end

  it 'returns an imported nodelist' do
    post '/imports', import: { file: Rack::Test::UploadedFile.new(import_nodelist, 'text/plain') }
    get '/DICOMNodes.plist'
    expect(response.status).to eq(200)
    expect(response.body).to eq(File.read(import_nodelist))
  end
end
