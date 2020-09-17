require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailは@がないと登録できないこと' do
      @user.email = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー本名が、名字と名前がそれぞれ必須であること' do
      @user.first_name = nil
      @user.family_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "Family name can't be blank")
    end

    it 'ユーザー本名は全角(漢字・ひらがな・カタカナ)で入力させること' do
      @user.first_name = 'aaa'
      @user.family_name = 'bbb'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid', 'Family name is invalid')
    end

    it 'ユーザー本名のフリガナが、名字と名前でそれぞれ必須であること' do
      @user.first_name_kana = nil
      @user.family_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "Family name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは全角(カタカナ)で入力させること' do
      @user.first_name_kana = 'aあ阿'
      @user.family_name_kana = 'iい井'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid', 'Family name kana is invalid')
    end
  end
end
