module ApplicationHelper

  def convert_array_to_string array
    array.map { |x| x.name }.join(', ')
  end

  def prevent_submission
    Time.now > Time.new(2014, 3, 25, 0, 0, 0, "+05:30")
  end

end
