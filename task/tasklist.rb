require 'rspec'
require_relative 'task'
require_relative 'todo'
require_relative 'anniversary'

# create a new class called tasklist
class TaskList
  def initialize
    @list = []
  end

  def tasklist_array
    @list
  end

  def add_task(input_task)
    @list << input_task
  end

  def show_completed
    completed_tasks = []
    @list.each do |task|
      if task.task_done? == true
        completed_tasks << task
      end
    end
    completed_tasks
  end

  def show_incomplete
    incomplete_tasks = []
    @list.each do |task|
      if task.task_done? == false
        incomplete_tasks << task
      end
    end
    incomplete_tasks
  end

  def todo_incomplete_due_today
    incomplete_tasks = []
    @list.each do |todo|
      if todo.class == ToDo
        if todo.task_done? == false
          if todo.get_due_date.jd == Date.today.jd
            incomplete_tasks << todo
          end
        end
      end
    end
    incomplete_tasks
  end

  def todo_incomplete_by_due
    incomplete_tasks = []
    @list.each do |todo|
      if todo.class == ToDo
        if todo.task_done? == false
          incomplete_tasks << todo
        end
      end
    end
    incomplete_tasks.sort {|todo_one, todo_two| todo_one.get_due_date.jd <=> todo_two.get_due_date.jd }
  end

  def all_incomplete_tasks
    incomplete_tasks = []
    @list.each do |todo|
      if todo.class == ToDo
        if todo.task_done? == false
          incomplete_tasks << todo
        end
      end
    end
    incomplete_tasks = incomplete_tasks.sort {|todo_one, todo_two| todo_one.get_due_date.jd <=> todo_two.get_due_date.jd }
    @list.each do |task|
      if task.class == Task
        if task.task_done? == false
          incomplete_tasks << task
        end
      end
    end
    incomplete_tasks
  end

  def anniversaries
    anniversaries = []
    @list.each do |anniversary|
      if anniversary.class == Anniversary
        anniversaries << anniversary
      end
    end
    anniversaries
  end

  def sorted_anniversaries
    anniversaries = []
    @list.each do |anniversary|
      if anniversary.class == Anniversary
        anniversaries << anniversary
      end
    end
    anniversaries.sort do |anni_one, anni_two|
      if anni_one.get_raw_date < Date.today.yday
        anni_one.get_raw_date
      else
        if Date.today.year%4 == 0
          anni_one.get_raw_date + 366
        else
          anni_one.get_raw_date + 365
        end
      end <=>
      if anni_two.get_raw_date < Date.today.yday
        anni_two.get_raw_date
      else
        if Date.today.year%4 == 0
          anni_two.get_raw_date + 366
        else
          anni_two.get_raw_date + 365
        end
      end
    end
  end

  def sort_all_tasks
    all_sorted_items = []
    @list.map do |item|
      if item.class == ToDo || item.class == Anniversary
        all_sorted_items << item
      end
    end
    all_sorted_items = all_sorted_items.sort do |item_one, item_two|
      if item_one.class == ToDo
        item_one.get_due_date.yday + ((item_one.get_due_date.year - Date.today.year)*365)
      elsif item_one.class == Anniversary
        if item_one.get_raw_date >= Date.today.yday
          item_one.get_raw_date
        else
          if Date.today.year%4 == 0
            item_one.get_raw_date + 366
          else
            item_one.get_raw_date + 365
          end
        end
      end <=>
      if item_two.class == ToDo
        item_two.get_due_date.yday + ((item_two.get_due_date.year - Date.today.year)*365)
      elsif item_two.class == Anniversary
        if item_two.get_raw_date >= Date.today.yday
          item_two.get_raw_date
        else
          if Date.today.year%4 == 0
            item_two.get_raw_date + 366
          else
            item_two.get_raw_date + 365
          end
        end
      end
    end
    @list.each do |item|
      if item.class == Task
        all_sorted_items << item
      end
    end
    all_sorted_items
  end

  # def sort_all_incomplete_by_month
  #   to_sort = []
  #   @list.each do |item|
  #     if item.task_done? == false
  #       if item.class == ToDo && item.get_due_date.month == Date.today.month
  #         to_sort << item
  #       elsif item.class == Anniversary && Time.at(item.get_raw_date*60*60*24).month
  #         to_sort << item
  #       end
  #     end
  #   end
  #   to_sort = to_sort.sort do |item_one, item_two|
  #     if item_one.class == ToDo
  #       item_one.get_due_date
  #     else
  #       something
  #     end
  # end
end
