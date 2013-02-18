require 'spec_helper'

describe User do

  context 'valid user' do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end

    it 'should save a basic user' do
      @user.save.should be_true
    end

    it 'has availability and knows how to use it' do
      @user.update_attributes(:available => true)
      @user.available.should be true
    end

  end

  context 'tz_order' do
    before(:each) do
      @london = FactoryGirl.create(:london_user)
      @sydney = FactoryGirl.create(:sydney_user)
      @la     = FactoryGirl.create(:la_user)
    end

    it 'can make timezones' do
      ActiveSupport::TimeZone.new(@london.time_zone).should_not be_nil
      ActiveSupport::TimeZone.new(@sydney.time_zone).should_not be_nil
      ActiveSupport::TimeZone.new(@la.time_zone).should_not be_nil
    end

    it 'gets a list' do
      User.tz_order.length.should eq 3
    end

    it 'sorts correctly' do
      User.tz_order.first.should eq @la
      User.tz_order.last.should  eq @sydney
    end

    it "doesn't die on a blank timezone" do
      @new = FactoryGirl.create(:available_no_tz_user)
      User.tz_order.length.should eq 4
    end

  end

end
