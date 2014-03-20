require 'axlsx'
module ReportFileGenerator
class DailyReportExcel
   def initialize(reports,path)
       @daily_reports = reports
       @file_path = path
   end

  def to_excel
    p = Axlsx::Package.new
    wb = p.workbook
    wb.styles do |s|
      default_cell = s.add_style :b => true,
                                 :sz => 12,
                                 :border => { :style => :thick, :color => "333333" },
                                 :alignment => { :horizontal => :center,
                                                 :vertical => :center ,
                                                 :wrap_text => true}
      date_format_cell = s.add_style :b => true,
                                     :sz => 12,
                                     :border => { :style => :thick, :color => "333333" },
                                     :alignment => { :horizontal => :center,
                                                     :vertical => :center ,
                                                     :wrap_text => true},
                                     :format_code => 'MM/DD/YYYY'
      wb.add_worksheet(:name => 'Report For') do |sheet|
        sheet.add_row ['Employee Number','','Employee Name','','Business Affairs Report Written Weeks','','Superior'], :style=>default_cell
        sheet.merge_cells("A1:B1")
        sheet.merge_cells("C1:D1")
        sheet.merge_cells("E1:F2")
        sheet.add_row ['AW062','','CHAN MYAE SAN HLAING','','','',' '], :style=>default_cell
        sheet.merge_cells("A2:B2")
        sheet.merge_cells("C2:D2")
        sheet.add_row ['Table Line','','','','','',''],:style => default_cell
        sheet.merge_cells("A3:G3")
        sheet.add_row ['Now Scheduled for week','','','','','',''],:style => default_cell
        sheet.merge_cells("A4:G4")
        sheet.add_row ['Project file sending, learning and follow up for office work','','','','','',''],:style => default_cell
        sheet.merge_cells("A5:G5")
        sheet.add_row ['Date','Time','Working Content','','','',''],:style => default_cell
        sheet.merge_cells("C6:E6")
        sheet.merge_cells("F6:G6")

        @daily_reports.each do |dr|
          sheet.add_row [dr.report_date,dr.start_time.strftime('%k:%m%P')+"-"+dr.end_time.strftime('%k:%m%P'),'Will be:',dr.plan,'','Report Problem:',dr.problem],:style =>default_cell
          row1 = sheet.rows.last
          sheet.add_row ['','','Experience:',dr.experience,'','Solution:',dr.solution],:style => default_cell
          row2 = sheet.rows.last
          sheet[row1.cells[0].r].style = date_format_cell
          row1.cells[0].merge row2.cells[0]
          row1.cells[1].merge row2.cells[1]
          row1.cells[3].merge row1.cells[4]
          row2.cells[3].merge row2.cells[4]
        end
        0.upto(5).each do |i|
          sheet.rows[i].height = 30
        end
        6.upto(sheet.rows.length-1).each do |j|
          sheet.rows[j].height = 90
        end
        sheet.column_widths 20,20,20,30,30,20,30

      end
    end
    p.serialize(@file_path)
  end

end

  end