require 'rspec'
require_relative 'anniversary'

describe 'Anniversary' do

  it 'creates an Anniversary class object' do
    expect { Anniversary }.to_not raise_error
  end

  it 'inherits the gets_title and title_change methods from Task' do
    a_anni = Anniversary.new(12)
    expect(a_anni.gets_title).to be_a String
    expect(a_anni.gets_title).to eq 'Untitled'
    a_anni.title_change 'Feed the monkeys'
    expect(a_anni.gets_title).to eq 'Feed the monkeys'
  end

  it 'has a date which is set on creation of the object' do
    a_anni = Anniversary.new(15)
    expect(a_anni.get_date).to be_a Array
    expect(a_anni.get_date).to eq ['Month: 1', 'Day: 15']
  end

  it 'has a gets_labels method which overrides the gets_labels method from Task' do
    a_anni = Anniversary.new(5)
    expect(a_anni.gets_labels).to be_a Array
    expect(a_anni.gets_labels).to eq ['Due Date: Month: 1, Day: 5', 'Title: Untitled', 'Description: Blank' ]
  end
end
