require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  def setup
    @membership = Membership.new(user_id: users(:matt).id,
                                 team_id: teams(:work).id)
  end

  test "should be valid" do
    assert @membership.valid?
  end

  test "should require user_id" do
    @membership.user_id = nil
    assert_not @membership.valid?
  end

  test "should require team_id" do
    @membership.team_id = nil
    assert_not @membership.valid?
  end

end
