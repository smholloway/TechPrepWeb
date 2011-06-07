module ApplicationHelper
  def title(page_title="Home")
    content_for(:title) { page_title }
  end
end
