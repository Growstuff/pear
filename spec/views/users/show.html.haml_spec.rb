require 'spec_helper'

describe 'users/show.html.haml', :type => 'view' do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
  end

  context 'signed out' do
    before(:each) do
      controller.stub(:current_user) { nil }
      render
    end

    it 'should not show an email address' do
      rendered.should_not contain "Email address:"
      rendered.should_not contain @user.email
    end
  end

  context 'signed in' do
    before(:each) do
      @me = FactoryGirl.create(:user)
      controller.stub(:current_user) { @me }
      render
    end

    it 'should show an email address' do
      rendered.should contain "Email address:"
      rendered.should contain @user.email
    end
  end
end
