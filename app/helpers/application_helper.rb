module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def yield_for(content_sym, default)
    output = content_for(content_sym)
    output = default if output.blank?
    output
  end  
end
