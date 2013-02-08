require 'spec_helper'

describe 'home/index.html.haml', :type => "view" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    controller.stub(:current_user) { @user }
    render
  end

  it 'should have a heading' do
    assert_select "h1", "Pear"
  end
end
