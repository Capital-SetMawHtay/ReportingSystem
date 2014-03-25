require 'zip'
require 'fileutils'
module ZipCompressions
  class ReportZipper

    def self.zip(report_files,zipfile_path)
      return unless report_files;
      Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|

        report_files.each do |f|
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          zipfile.add(f.file_name, f.file_path) if File.exist?(f.file_path)
        end
      end
    end
  end

end







class ZipperController < ApplicationController

  def create
    @today_files = ReportFile.today
    ZipCompressions::ReportZipper.zip(@today_files,generate_zip_path)
  end


  private
    def generate_zip_path
      base_path = "#{Rails.root}/storage/zips/#{Date.today}"
      FileUtils.mkdir_p(base_path)
      file_name = "awitd_daily_reports_#{Date.today}.zip"
      base_path.concat(file_name)

    end


end
