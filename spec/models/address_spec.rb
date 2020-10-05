require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end
  describe '商品購入機能' do

    context '商品が購入できる場合' do
      
      it '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が入力されていたら購入できること' do
        expect(@address).to be_valid
      end

    end

    context '商品が購入できない場合' do
      
      it '配送先の情報として郵便番号が入力されていない場合購入できないこと' do
        @address.post_code = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Post code can't be blank")
      end
      
      it '配送先の情報として都道府県が選択されていなかった場合購入ができないこと' do
        @address.prefecture_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it '都道府県の選択肢が---の場合購入できないこと' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      
      it '配送先の情報として市区町村が入力されていない場合購入できない' do
        @address.city = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("City can't be blank")
      end
      
      it '配送先の情報として番地が入力されていない場合購入できない' do
        @address.address = nil 
        @address.valid?
        expect(@address.errors.full_messages).to include("Address can't be blank")
      end
      
      it '配送先の情報として電話番号が入力されていない場合購入できないこと' do
        @address.phone_number = nil 
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number can't be blank")
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
end
  