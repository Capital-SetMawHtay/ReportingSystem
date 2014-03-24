class ReportFile < ActiveRecord::Base
  attr_accessible :file_date, :file_path, :report_id

  belongs_to :report

  #======Scopes=========##
  # :today limits the report files only for today date
  scope :today, lambda { where(file_date: Date.today)}

  #======class methods=====##

  def file_name
    file_path.split('/').last
  end
end
