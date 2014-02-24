require_relative '../support/feature_helpers'

describe 'Member Report Writing' do
  context 'When member is logged in' do
    before(:each) do
      member_login
    end
    it 'shows this week report page' do
      visit reports_path
      page.should have_selector('#reports')

    end
    context 'when this week reports are not generated yet' do

      it 'shows generate report button' do
        visit reports_path
        page.should have_content('You have not generated reports for this week yet')
        page.should have_button('Generate Now')
      end
      context 'when generate report button is clicked' do
        before(:each) do
           visit reports_path
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
      end
    end
  end
end