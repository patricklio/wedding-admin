module ApplicationHelper
  def flash_class(level)
    div_class = ""
    case level
        # when "notice" then div_class = "alert alert-info"
        when "success" then div_class = "alert alert-success"
        when "error" then div_class = "alert alert-error"
        when "alert" then div_class = "alert alert-error"
    end

    div_class
  end

  def opened_info_request_number
    InfoRequest.opened.count
  end
end
