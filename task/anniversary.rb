require_relative 'task'

class Anniversary < Task

  def initialize(input_date)
    super()
    @date = input_date
  end

  def get_date
    return_date = []
    return_date << 'Month: ' + Time.at(@date*60*60*24).month.to_s
    return_date << 'Day: ' + Time.at(@date*60*60*24).mday.to_s
    return_date
  end

  def get_raw_date
    @date
  end

  def gets_labels
    label_array = []
    label_array << 'Due Date: ' + get_date[0] + ', ' + get_date[1]
    label_array << 'Title: ' + @title
    label_array << 'Description: ' + @description
    label_array
  end

end
