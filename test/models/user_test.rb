require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without required fields' do
    user = User.new
    assert_not user.save, 'Saved the user without a required field'
  end

  test 'should save valid user' do
    user = User.new(name: 'John Doe', email: 'test@example.com', password: 'securepassword')
    assert user.save, "Couldn't save a valid user"
  end
end
