require 'rspec'
require_relative 'tasklist'

# I can add all of my Tasks to a TaskList.

# create a new class called tasklist
describe 'TaskList Class' do
  it 'should be able to create a Tasklist class object' do
    expect { TaskList.new }.to_not raise_error
  end

  # Create an array to hold Tasks
  it 'has an array to hold classes which is empty on creation' do
    a_tasklist = TaskList.new
    expect(a_tasklist.tasklist_array).to be_a Array
    expect(a_tasklist.tasklist_array).to eq []
  end

  # I can add a task to the task array
  it 'able to add task to task_array' do
    a_tasklist = TaskList.new
    laundry = Task.new
    dishes = Task.new
    laundry.title_change 'laundry'
    dishes.title_change 'dishes'
    a_tasklist.add_task laundry
    a_tasklist.add_task dishes
    expect(a_tasklist.tasklist_array).to eq [laundry, dishes]
    expect(a_tasklist.tasklist_array[0].gets_title).to eq laundry.gets_title
  end

  it 'should be able to change the status of Tasks in it between true and false' do
    a_tasklist = TaskList.new
    a_task = Task.new
    a_tasklist.add_task a_task
    expect(a_tasklist.tasklist_array[0].task_done?).to be_a FalseClass
    a_tasklist.tasklist_array[0].task_done = true
    expect(a_tasklist.tasklist_array[0].task_done?).to be_a TrueClass
  end

  #  I can show all the completed items.
  it 'should be able to show the completed tasks in the array' do
    a_tasklist = TaskList.new
    laundry = Task.new
    clean_house = Task.new
    a_task = Task.new
    laundry.title_change 'Laundry'
    clean_house.title_change 'Clean house'
    laundry.task_done = true
    a_task.task_done = true
    a_tasklist.add_task laundry
    a_tasklist.add_task clean_house
    a_tasklist.add_task a_task
    expect(a_tasklist.show_completed).to eq [laundry, a_task]
  end

  it 'should be able to show the incomplete tasks in the array' do
    a_tasklist = TaskList.new
    laundry = Task.new
    clean_house = Task.new
    a_task = Task.new
    laundry.title_change 'Laundry'
    clean_house.title_change 'Clean house'
    laundry.task_done = true
    a_task.task_done = true
    a_tasklist.add_task laundry
    a_tasklist.add_task clean_house
    a_tasklist.add_task a_task
    expect(a_tasklist.show_incomplete).to eq [clean_house]
  end

  it 'should be able to add ToDo Tasks' do
    a_tasklist = TaskList.new
    a_todo = ToDo.new
    a_tasklist.add_task a_todo
    expect(a_tasklist.tasklist_array).to eq [a_todo]
  end

  it 'should be able to list all incomplete items that are due today' do
    a_tasklist = TaskList.new
    a_todo = ToDo.new
    b_todo = ToDo.new
    c_todo = ToDo.new
    d_todo = ToDo.new

    a_todo.change_due_date -30
    b_todo.change_due_date -30

    a_todo.task_done = true
    c_todo.task_done = true

    a_tasklist.add_task a_todo
    a_tasklist.add_task b_todo
    a_tasklist.add_task c_todo
    a_tasklist.add_task d_todo

    expect(a_tasklist.todo_incomplete_due_today).to be_a Array
    expect(a_tasklist.todo_incomplete_due_today).to eq [b_todo]
  end

  it 'should be able to list all incomplete items in order of due date' do
    a_tasklist = TaskList.new
    a_todo = ToDo.new
    b_todo = ToDo.new
    c_todo = ToDo.new
    d_todo = ToDo.new
    e_todo = ToDo.new
    f_todo = ToDo.new

    a_todo.change_due_date 20
    b_todo.change_due_date 15
    c_todo.change_due_date 78
    d_todo.change_due_date -1

    e_todo.task_done = true
    f_todo.task_done = true

    a_tasklist.add_task a_todo
    a_tasklist.add_task b_todo
    a_tasklist.add_task c_todo
    a_tasklist.add_task d_todo
    a_tasklist.add_task e_todo
    a_tasklist.add_task f_todo

    expect(a_tasklist.todo_incomplete_by_due).to be_a Array
    expect(a_tasklist.todo_incomplete_by_due).to eq [d_todo, b_todo, a_todo, c_todo]
  end

  it 'should be able to create a TaskList with both Tasks and Todos in order of due date' do
    a_tasklist = TaskList.new
    a_task = Task.new
    b_todo = ToDo.new
    c_task = Task.new
    d_todo = ToDo.new
    e_todo = ToDo.new
    f_todo = ToDo.new

    b_todo.change_due_date 15
    d_todo.change_due_date -1

    e_todo.task_done = true
    f_todo.task_done = true

    a_tasklist.add_task a_task
    a_tasklist.add_task b_todo
    a_tasklist.add_task c_task
    a_tasklist.add_task d_todo
    a_tasklist.add_task e_todo
    a_tasklist.add_task f_todo

    expect(a_tasklist.all_incomplete_tasks).to be_a Array
    expect(a_tasklist.all_incomplete_tasks).to eq [d_todo, b_todo, a_task, c_task]
  end

  it 'should show all Anniversary objects in the @list' do
    a_list = TaskList.new
    a_anni = Anniversary.new(10)
    b_anni = Anniversary.new(1)
    c_anni = Anniversary.new(25)

    a_list.add_task a_anni
    a_list.add_task b_anni
    a_list.add_task c_anni

    expect(a_list.anniversaries).to be_a Array
    expect(a_list.anniversaries).to eq [a_anni, b_anni, c_anni]
  end

  it 'should sort all upcoming Anniversary objects with soonest first' do
    a_list = TaskList.new
    a_anni = Anniversary.new(10)
    b_anni = Anniversary.new(1)
    c_anni = Anniversary.new(365)

    a_list.add_task a_anni
    a_list.add_task b_anni
    a_list.add_task c_anni

    expect(a_list.sorted_anniversaries).to be_a Array
    expect(a_list.sorted_anniversaries).to eq [b_anni, a_anni, c_anni]
  end

  it 'should be able to sort all incomplete tasks in a month by the due date with the soonest first (test A)' do
    a_list = TaskList.new
    a_task = Task.new
    b_task = Task.new
    c_todo = ToDo.new
    d_todo = ToDo.new
    e_anni = Anniversary.new(29)
    f_anni = Anniversary.new(3)

    d_todo.change_due_date -(Date.today.yday + 29) + 10

    expect(d_todo.get_due_date).to be_a Date
    expect(d_todo.get_due_date.yday).to eq 10

    a_list.add_task a_task
    a_list.add_task b_task
    a_list.add_task c_todo
    a_list.add_task d_todo
    a_list.add_task e_anni
    a_list.add_task f_anni

    expect(a_list.sort_all_tasks).to be_a Array
    expect(a_list.sort_all_tasks).to eq [d_todo, c_todo, f_anni, e_anni, a_task, b_task]
  end

  it 'should be able to sort all incomplete tasks in a month by the due date with the soonest first (test B)' do
    a_list = TaskList.new
    a_task = Task.new
    b_task = Task.new
    c_todo = ToDo.new
    d_todo = ToDo.new
    e_anni = Anniversary.new(10)
    f_anni = Anniversary.new(360)

    d_todo.change_due_date 365

    expect(d_todo.get_due_date).to be_a Date
    expect(d_todo.get_due_date.yday).to eq 177

    a_list.add_task a_task
    a_list.add_task b_task
    a_list.add_task c_todo
    a_list.add_task d_todo
    a_list.add_task e_anni
    a_list.add_task f_anni

    expect(a_list.sort_all_tasks).to be_a Array
    expect(a_list.sort_all_tasks).to eq [c_todo, f_anni, e_anni, d_todo, a_task, b_task]
  end
end
