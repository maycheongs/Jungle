require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Saves a new user' do
    @user =
      User.new(
        first_name: 'Bob',
        last_name: 'Builder',
        password: 'password',
        password_confirmation: 'password',
        email: 'bob@bob.com',
      )
    expect(@user.save).to be_truthy
  end
  describe 'Validations' do
    context 'password' do
      it 'requires confirmation' do
        @user =
          User.new(
            first_name: 'Bob',
            last_name: 'Builder',
            password: 'password',
            password_confirmation: nil,
            email: 'bob@bob.com',
          )
        expect(@user.save).to be_falsey
        expect(@user.errors.full_messages).to include(
          "Password confirmation can't be blank",
        )
      end
      it 'confirmation matches the password' do
        @user =
          User.new(
            first_name: 'Bob',
            last_name: 'Builder',
            password: 'password',
            password_confirmation: 'notpassword',
            email: 'bob@bob.com',
          )
        expect(@user.save).to be_falsey
        expect(@user.errors.full_messages).to include(
          "Password confirmation doesn't match Password",
        )
      end
      it 'requires a minimum length' do
        @user =
          User.new(
            first_name: 'Bob',
            last_name: 'Builder',
            password: 'abc',
            password_confirmation: 'abc',
            email: 'bob@bob.com',
          )
        expect(@user.save).to be_falsey
        expect(@user.errors[:password].to_s).to include('is too short')
      end
    end
    context 'email' do
      before do
        @email = 'new@email.com'
        @user1 =
          User.create!(
            first_name: 'Bob',
            last_name: 'Builder',
            password: 'password',
            password_confirmation: 'password',
            email: @email,
          )
      end

      it 'must be unique' do
        @user2 =
          User.new(
            first_name: 'Bob',
            last_name: 'Too',
            password: 'hello',
            password_confirmation: 'hello',
            email: @email,
          )
        expect(@user2.save).to be_falsey
        expect(@user2.errors[:email]).to include('has already been taken')
      end
    end

    it 'should require an email' do
      @user =
        User.new(
          first_name: 'Bob',
          last_name: 'Builder',
          password: 'password',
          password_confirmation: 'password',
          email: nil,
        )
      expect(@user.save).to be_falsey
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'should require a first name' do
      @user =
        User.new(
          first_name: nil,
          last_name: 'Builder',
          password: 'password',
          password_confirmation: 'password',
          email: 'bob@bob.com',
        )
      expect(@user.save).to be_falsey
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'should require a last name' do
      @user =
        User.new(
          first_name: 'Bob',
          last_name: nil,
          password: 'password',
          password_confirmation: 'password',
          email: 'bob@bob.com',
        )
      expect(@user.save).to be_falsey
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user =
        User.create(
          first_name: 'Nike',
          last_name: 'Adidas',
          email: 'test@test.com',
          password: 'password',
          password_confirmation: 'password',
        )
    end

    it 'authenticates a valid user' do
      logged_in =
        User.authenticate_with_credentials('test@test.com', 'password')
      expect(logged_in).to eq(@user)
    end

    it 'returns nil for invalid user/password' do
      logged_in =
        User.authenticate_with_credentials('test@test.com', 'notpassword')
      expect(logged_in).to be_nil
    end
    it 'successfully logs user if email is correct but wrongly case or has trailing spaces' do
      logged_in =
        User.authenticate_with_credentials('   test@TEST.com', 'password')
      expect(logged_in).to eq(@user)
    end
  end
end
