require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end
  describe '商品購入機能' do
    it '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が入力されていたら購入できること' do
      expect(@address).to be_valid
    end

    it '配送先の情報として郵便番号・都道府県・市区町村・番地・電話番号のどれか一つでも入力されていなかったら購入できないこと' do
      @address.post_code = nil
      @address.prefecture_id = nil
      @address.city = nil
      @address.address = nil
      @address.phone_number = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Post code can't be blank",
                                                       'Post code is invalid. Include hyphen(-)',
                                                       "Prefecture can't be blank",
                                                       'Prefecture is not a number',
                                                       "City can't be blank",
                                                       "Address can't be blank",
                                                       "Phone number can't be blank",
                                                       'Phone number is invalid')
    end

    it '郵便番号にはハイフンが必要であること' do
      @address.post_code = '1234567'
      @address.valid?
      expect(@address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end

    it '電話番号はハイフン不要で11桁以内である事' do
      @address.phone_number = '090-1234-56789'
      @address.valid?
      expect(@address.errors.full_messages).to include('Phone number is invalid')
    end
  end
end
