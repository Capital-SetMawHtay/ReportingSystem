module ReportsHelper

  def present_report_status(status)
    case status
      when 'pending'
        'fa fa-question-circle tip-buttom radius'
      when 'submitted'
        'fa fa-check-circle tip-buttom radius'
      when 'reviewed'
        'fa fa-hand-o-right tip-buttom radius'
      else
        'fa fa-paperclip tip-buttom radius'
    end
  end
end
