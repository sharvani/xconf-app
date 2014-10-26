module ApplicationHelper

  def convert_array_to_string array
    array.map { |x| x.name }.join(', ')
  end

  def prevent_submission
    Time.now > Time.new(2014, 3, 25, 0, 0, 0, "+05:30")
  end

  def category_options(categories)
    options_for_select(categories.map { |category| ["#{category.name} (#{category.time_in_min}min)", category.id] })
  end

  def admin_user(user)
    AdminUser.exists?(name: user)
  end
end
