module ApplicationHelper

  def format_datetime(datetime, format = "%Y-%m-%d %H:%d:%S")
    return nil if datetime.blank?
    datetime.strftime(format)
  end

  def nav_link(text, path, controllers = [])
    class_name = current_page?(path) ? 'active' : nil
    class_name ||= controllers.include?(controller_name) ? 'active' : nil

    content_tag(:li, class: class_name) do
      link_to text, path
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

end
