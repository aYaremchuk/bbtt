module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :warning then 'alert alert-danger'
    when :alert then 'alert alert-danger'
    end
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "#{flash_class(msg_type)} alert-dismissible", role: 'alert') do
        concat message
        concat content_tag(:button, '×',
                           class: 'close',
                           data: { dismiss: 'alert' },
                           'aria-label': 'Close',
                           type: 'button')
      end)
    end
    nil
  end
end
