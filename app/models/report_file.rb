class ReportFile < ActiveRecord::Base
  attr_accessible :file_date, :file_path, :report_id

  belongs_to :report
end
