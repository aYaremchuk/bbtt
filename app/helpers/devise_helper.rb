module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved', count: resource.errors.count,
                                                   resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger alert-dismissible" role="alert">
        <p>#{sentence}</p>
        <ul>#{messages}</ul>
    <button class="close" data-dismiss="alert" aria-label="Close" type="button">×</button></div>
    HTML

    html.html_safe
  end
end
