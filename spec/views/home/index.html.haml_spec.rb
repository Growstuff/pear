require 'spec_helper'

describe 'home/index.html.haml', :type => "view" do
  before(:each) do
    controller.stub(:current_user) { nil }
  end

  it 'should have a heading' do
    render
    assert_select "h1", "Pear"
  end

  context 'signed out' do
    it 'should have a fancy sign in button' do
      render
      assert_select "a[href=#{user_omniauth_authorize_path(:github)}]"
    end

    it 'shows nobody available' do
      render
      rendered.should include 'Nobody'
    end

    it 'shows the availability table' do
      @someone = FactoryGirl.create(:available_user)
      assign(:available, [@someone])
      render
      assert_select 'table'
    end
  end

  context 'signed in' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      controller.stub(:current_user) { @user }
      render
    end
    it 'has a sign out link' do
      assert_select "a", "Sign out."
    end
    it 'has a form for your availability and time zone' do
      assert_select 'form' do
        assert_select 'input#user_available[type=checkbox]'
        assert_select 'select#user_time_zone'
        assert_select 'input[type=submit]'
      end
    end

    it 'has mentoring check boxes' do
      assert_select 'input#user_can_mentor[type=checkbox]'
      assert_select 'input#user_wants_mentor[type=checkbox]'
    end
  end

  context 'mentoring' do
    before(:each) do
      @mentor = FactoryGirl.create(:mentor)
      assign(:available, [@mentor])
      # controller.stub(:current_user) { @mentor }
      render
    end

    it 'mentor is what we expect' do
      @mentor.should be_an_instance_of User
      @mentor.can_mentor.should be_true
    end

    it 'has checkmarks for mentoring' do
      assert_select 'i.icon-ok', :count => 2
    end
  end

end
