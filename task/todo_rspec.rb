require 'rspec'
require_relative 'todo'

describe 'ToDo Class' do
  it 'should create a ToDo class object' do
    expect { ToDo }.to_not raise_error
  end

  it 'should inherit gets_title and title_change methods from the Task class' do
    a_todo = ToDo.new
    expect(a_todo.gets_title).to eq 'Untitled'
    a_todo.title_change 'Todo 1'
    expect(a_todo.gets_title).to eq 'Todo 1'
  end

  it 'should be created with a @due_date which defaults to the current day + 30 days' do
    a_todo = ToDo.new
    expect(a_todo.get_due_date).to be_a Date
    expect(a_todo.get_due_date.yday).to eq Date.today.yday + 30
  end

  it 'should be able to change the @due_date by an amount of days' do
    a_todo = ToDo.new
    old_due_date = a_todo.get_due_date
    a_todo.change_due_date 365
    expect(a_todo.get_due_date.jd).to eq old_due_date.jd + 365
  end

  it 'should override gets_labels method from Task class to return a different array' do
    a_todo = ToDo.new
    expect(a_todo.gets_labels).to be_a Array
    expect(a_todo.gets_labels).to eq ['Due Date: 2016-06-26', 'Title: Untitled', 'Description: Blank' ]
  end
end
