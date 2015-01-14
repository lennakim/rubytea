module ApplicationHelper

  def nav_link(text, path, controllers = [])
    class_name = current_page?(path) ? 'active' : nil
    class_name ||= controllers.include?(controller_name) ? 'active' : nil

    content_tag(:li, class: class_name) do
      link_to text, path
    end
  end
end
