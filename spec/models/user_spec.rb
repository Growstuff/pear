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
end
