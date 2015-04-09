require 'spec_helper'

describe User do
  context 'validations' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should be valid with mandatory attributes' do
      @user.should be_valid
    end

    it 'should not be valid without email' do
      @user.email = nil
      @user.should_not be_valid
    end

    it 'should not be valid without name' do
      @user.name = nil
      @user.should_not be_valid
    end

    it 'should not be valid with a short password' do
      @user.password = "short"
      @user.password_confirmation = "short"
      @user.should_not be_valid
    end
  end
end

describe User, '#has_roles?' do
  before(:each) do
    @admin = FactoryGirl.create(:admin)
  end

  it 'checks ig the user has any of the listed roles' do
    @admin.has_roles?([:admin, :supervisor]).should be_true
    @admin.has_roles?([:supervisor]).should be_false
    @admin.has_roles?([]).should be_false
  end
end
