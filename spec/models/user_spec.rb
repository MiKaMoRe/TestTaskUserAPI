require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should_not allow_value("testname123").for(:first_name) }
  it { should_not allow_value("testname123").for(:last_name) }
  it { should allow_value("Testname").for(:first_name) }
  it { should allow_value("Testname").for(:last_name) }
end
