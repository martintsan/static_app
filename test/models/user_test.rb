require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:martin)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email should accept valid addresses' do
    valid_addresses = %w(martin@example.com
                         MARIN_NETT@icloud.com foo-bar@foo.bar.org
                         foo.bar@foo.bar.org foo+bar@foo.bar.org)
    valid_addresses.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test 'email should reject invalid addresses' do
    invalid_addresses = %w(martin@example,com
                           MARIN_NETT_at_icloud.com foo-bar@foo.bar@org.cn
                           foobar@foo+bar.org)
    invalid_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.downcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Martin_Nett@iCloud.Com'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email,
                 "expected #{@user.reload.email} to be #{mixed_case_email.downcase}"
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test "user should be authenticate by password" do
    assert_not !!@user.authenticate('foobaz')
    assert !!@user.authenticate('foobar')
  end
end
