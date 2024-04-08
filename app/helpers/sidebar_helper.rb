module SidebarHelper
  def sidebar_menu_entry(text, path, svg_icon)
    current_path = request.path
    is_current_page = current_path == path


    link_to path do
      content_tag(:div, class: "sidebar-menu__item#{' active' if is_current_page}") do
        concat image_tag("svg/#{is_current_page ? 'filled' : 'outline'}/#{svg_icon}.svg", alt: text)
        concat content_tag(:span, text, class: 'sidebar-menu__item__text')
      end
    end
  end
end
