require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save if all fields are valid' do
      user = User.new(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
      user.save!
      expect(User.find_by(email: 'example@gmail.com')).to eql(user)
    end

    describe 'Password' do
      it 'should not save without password' do
        user = User.new(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password_confirmation: 'password')
        user.save
  
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
  
      it 'should not save without password confirmation' do
        user = User.new(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password')
        user.save
  
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
      end
  
      it 'should not save if password and confirmation password dont match' do
        user = User.new(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'jonny5')
        user.save
  
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
  
      it 'should not save with password less than 3 characters' do
        user = User.new(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'jo', password_confirmation: 'jo')
        user.save
  
        expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
      end
    end

    describe 'Email' do
      it 'should not save without email' do
        user = User.new(first_name: 'First', last_name: 'Last', password: 'password', password_confirmation: 'password')
        user.save
  
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'should not save if user exists' do
        user = User.new(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
        user.save
  
        user_copy = User.new(first_name: 'First', last_name: 'Last', email: 'ExAmPle@gmail.com', password: 'password', password_confirmation: 'password')
        user_copy.save
  
        expect(user_copy.errors.full_messages).to include("Email has already been taken")
      end
    end

    describe 'Names' do
      it 'should not save without first name' do
        user = User.new(last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
        user.save
  
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it 'should not save without last name' do
        user = User.new(first_name: 'First', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
        user.save
  
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return user with correct email and passord' do
      user = User.create(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
      
      authenticated = User.authenticate_with_credentials('example@gmail.com', 'password')

      expect(authenticated).to eql(user)
    end

    it 'should return nil if email and password are invalid' do
      user = User.create(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
      
      authenticated = User.authenticate_with_credentials('example@gmail.com', 'jony')

      expect(authenticated).to be nil
    end

    it 'should trim whitespaces' do
      user = User.create(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
      
      authenticated = User.authenticate_with_credentials(' example@gmail.com  ', 'password')

      expect(authenticated).to eql(user)
    end

    it 'should be case insensitive' do
      user = User.create(first_name: 'First', last_name: 'Last', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
      
      authenticated = User.authenticate_with_credentials('EXAMPLE@gmail.com', 'password')

      expect(authenticated).to eql(user)
    end
  end
end