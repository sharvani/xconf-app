module ApplicationHelper

  def convert_array_to_string array
    array.map { |x| x.name }.join(', ')
  end

  def prevent_submission
    Time.now > Time.parse(Setting.submission_end_time)
  end

  def prevent_vote?
    Time.now > Time.parse(Setting.vote_end_time)
  end

  def category_options(categories)
    options_for_select(categories.map { |category| ["#{category.name} (#{category.time_in_min}min)", category.id] })
  end
end
