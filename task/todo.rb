require_relative 'task'

class ToDo < Task
  def initialize
    super
    @due_date = Date.new((Date.today + 30).year, (Date.today + 30).month, (Date.today + 30).day)
  end

  def get_due_date
    @due_date
  end

  def change_due_date(change_due_date_by_days)
    changed_date_by_seconds = Time.at(@due_date.to_time) + (change_due_date_by_days*60*60*24)

    modify_year = changed_date_by_seconds.year
    modify_month = changed_date_by_seconds.month
    modify_day = changed_date_by_seconds.day

    @due_date = Date.new(modify_year, modify_month, modify_day)
  end

  def gets_labels
    list = ['Due Date: ' + @due_date.to_s]
    list << 'Title: ' + @title.to_s
    list << 'Description: ' + description.to_s
  end
end
