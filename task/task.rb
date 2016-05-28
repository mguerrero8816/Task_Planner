# create a new class called task
class Task
  def initialize
    @title = 'Untitled'
    @description = 'Blank'
    @is_done = false
  end

  def gets_title
    @title
  end

  def title_change(input_title)
    @title = input_title
  end

  def description
    @description
  end

  def change_description(input_description)
    @description = input_description
  end

  def gets_labels
    labels_array =[]
    labels_array << 'Title: ' + @title
    labels_array << 'Description: ' + @description
  end

  def task_done=(input_status)
    @is_done = input_status
  end

  def task_done?
    @is_done
  end
end
