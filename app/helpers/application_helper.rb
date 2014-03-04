module ApplicationHelper

  def convert_array_to_string array
    array.map { |x| x.name }.join(', ')
  end

end
