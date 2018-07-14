# frozen_string_literal: true

require 'rails_helper'
require 'securerandom'

RSpec.describe User, type: :model do
  subject { described_class.new }

  it 'is valid with all of the correct data' do
    subject.first_name = 'Geoffery'
    subject.last_name = 'Chaucer'
    random_password = SecureRandom.base64(12)
    subject.password = random_password
    subject.password_confirmation = random_password
    subject.email = 'geoffery_chaucer@catmail.com'
    expect(subject).to be_valid
  end
end
