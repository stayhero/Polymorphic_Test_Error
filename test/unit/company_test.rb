require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  test "Company should have 2 departments" do
    assert Company.find(1).departments.size == 2
  end

  test "Company should have 2 users" do
    assert Company.find(1).users.size == 2
  end

  test "Company should have 1 designer" do
    assert Company.find(1).designers.size == 1
  end

end
