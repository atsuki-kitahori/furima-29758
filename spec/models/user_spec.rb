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
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it 'emailは@がないと登録できないこと' do
      @user.email = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'ユーザー本名が、名字と名前がそれぞれ必須であること' do
      @user.first_name = nil
      @user.family_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください", "名字を入力してください")
    end

    it 'ユーザー本名は全角(漢字・ひらがな・カタカナ)で入力させること' do
      @user.first_name = 'aaa'
      @user.family_name = 'bbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("名前は全角で入力してください", "名字は全角で入力してください")
    end

    it 'ユーザー本名のフリガナが、名字と名前でそれぞれ必須であること' do
      @user.first_name_kana = nil
      @user.family_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前(フリガナ)を入力してください", "名字(フリガナ)を入力してください")
    end

    it 'ユーザー本名のフリガナは全角(カタカナ)で入力させること' do
      @user.first_name_kana = 'aあ阿'
      @user.family_name_kana = 'iい井'
      @user.valid?
      expect(@user.errors.full_messages).to include("名前(フリガナ)は全角カタカナで入力してください", "名字(フリガナ)は全角カタカナで入力してください")
    end

    it '生年月日が必須であること' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("誕生日を入力してください")
    end
  end
end
