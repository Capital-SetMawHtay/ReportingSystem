require 'cancan/matchers'

describe Ability do
    context 'when leader' do
      before(:each) do
        @team = build(:team,name: 'Ruby')
        @leader = build(:user,id: 1,role: 'leader',team: @team)
        @ability = Ability.new(@leader)
      end
      it 'allows to access own reports' do
        rp1 = build(:report,user: @leader)
        @ability.should be_able_to(:index,rp1)
      end

      it 'allows to update own team member reports' do
        team_member_reports = build(:report,user: build(:user,team: @team))
        (@ability.can?(:update, team_member_reports)).should be_true
      end

      it 'does not allow to create others reports' do
        rp1 = build(:report,user: build(:user,role: 'leader'))
        (@ability.cannot?(:update, rp1)).should be_true
      end


    end

    context 'when member' do
      before(:each) do
        @member = build(:user,role: 'member')
        @ability = Ability.new(@member)
      end
      it 'allows to access own reports' do
        rp1 = build(:report,user: @member)
        (@ability.can?(:index,rp1)).should be_true
      end


      it 'does not allow to update others reports' do
        user2 = create(:user,role: 'member')
        rp1 = build(:report,user: user2)
        (@ability.cannot?(:update, rp1)).should be_true
      end
    end

  end
