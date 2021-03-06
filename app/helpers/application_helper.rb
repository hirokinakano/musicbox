module ApplicationHelper
  include SessionsHelper

  #ページごとにタイトルを返す
  def full_title(page_title = '')
    base_title = "Musicbox"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
