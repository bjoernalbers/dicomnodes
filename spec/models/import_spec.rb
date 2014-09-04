require 'spec_helper'

describe Import do
  it 'validates the file presence' do
    import = Import.new(file: nil)
    expect(import).to be_invalid
    expect(import).to have(1).errors_on(:file)
  end
end
