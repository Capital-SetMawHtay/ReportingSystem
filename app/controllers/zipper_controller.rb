module ZipCompressions
   class ReportZipper

   end

end





class ZipperController < ApplicationController

  def create
    @today_files = ReportFile.today
  end


end
