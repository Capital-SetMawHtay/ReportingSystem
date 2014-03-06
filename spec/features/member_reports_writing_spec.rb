require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier
describe 'Member Report Writing' do
  context 'When member is logged in' do
    before(:each) do
      @member=create(:user,email: 'member@gmail.com',password: 'member',role: 'member')
      member_login
    end
    it 'shows this week report page' do
      page.should have_selector('#reports')

    end
    context 'when this week reports are not generated yet' do

      it 'shows generate report button' do
        page.should have_content('You have not generated reports for this week yet')
        page.should have_button('Generate Now')
      end
      context 'when generate report button is clicked' do
        before(:each) do
           visit user_reports_path(@member)
           click_button 'Generate Now'
           @first = Date.today.beginning_of_week
           @last = Date.today.beginning_of_week + 4
        end
        it 'generates correct reports for the week' do
          within('#reports') do
            page.should_not have_link('Generate Now')
            (@first..@last).each do |day|
              page.should have_content(day)
            end
          end

        end

        it 'sets correct status for the generated reports' do
          generated_report1 = Report.last
          within("##{dom_id(generated_report1)}")do
            page.should have_content('pending')
          end
        end
      end

    end
    context 'when reports are generated' do
      before(:each) do
        @first = Date.today.beginning_of_week
        @report1 = create(:report,report_date: Date.today.beginning_of_week,user: @member)
        @report2 = create(:report,report_date: @first+1,user: @member)
        @report3 = create(:report,report_date: @first+2,user: @member)
        @report4 = create(:report,report_date: @first+3,user: @member)
        @report5 = create(:report,report_date: @first+4,user: @member)
        visit user_reports_path(@member)
      end

      it 'has links to write report' do
         within("##{dom_id(@report2)}") do
            page.should have_link('Edit')
         end
      end

      describe 'Writing report' do
        before(:each) do
          within("##{dom_id(@report2)}") do
            click_link 'Edit'
          end
        end
        it 'shows report edit page' do
          page.should have_content('Edit Report')
          page.should have_selector("#edit_#{dom_id(@report2)}")
        end

        it 'has edit form with correct value' do
          within("#edit_#{dom_id(@report2)}") do
            find('#report_plan').value.should eq(@report2.plan)
            find('#report_experience').value.should eq(@report2.experience)
            find('#report_problem').value.should eq(@report2.problem)
            find('#report_solution').value.should eq(@report2.solution)
          end
        end

        it 'correctly update the report' do
          within("#edit_#{dom_id(@report2)}") do
            fill_in 'Plan', with: 'This is plan'
            fill_in 'Experience', with: 'This is experience'
            fill_in 'Problem', with: 'This is problem'
            fill_in 'Solution', with: 'This is solution'
            click_button 'Write'
          end
          page.should have_content('Report successfully updated')
        end
      end

      describe 'Submitting report' do
        before(:each) do
          visit user_reports_path(@member)
        end

        it 'has a submit report button' do
          within("##{dom_id(@report1)}") do
            page.should have_button('Submit Report')
          end
        end

        it'allows to submit report' do
          within("##{dom_id(@report1)}") do
            click_button 'Submit Report'
          end
          within("##{dom_id(@report1)}") do
            page.should have_content('submitted')
          end
        end
      end
    end
  end
end