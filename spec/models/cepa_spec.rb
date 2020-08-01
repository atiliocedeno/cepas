require 'rails_helper'

RSpec.describe Cepa, type: :model do
  it "Cepa with unique names" do
    cepa = Cepa.create([{ :name => 'test' }, { :name => 'test' }])
    expect(cepa).to_not be_valid  
  end 

  it "Cepa with name nil" do
    # cepas = Cepa.create([{ :name => nil }, { :name => '' }, {:name => 'Carmenere'}])
    cepas = Cepa.create(name: nil)
    expect(cepas).to be_valid
  end

  it "Cepa with empty name" do
    cepas = Cepa.create(name: '')
    expect(cepas).to be_valid 
  end 

  it "Cepa with name" do
    cepas = Cepa.create(name: 'Carmenere')
    expect(cepas).to be_valid 
  end 
end
