require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end

    it '画像、商品名、説明、カテゴリー情報、商品の状態、配送料の負担、配送元の地域、発送までの日数、価格の全ての項目が入力されていれば出品登録できること' do
      expect(@item).to be_valid
    end

    it 'ログインしているユーザーだけが出品ページへ遷移できること' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end

    it '画像は1枚必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'カテゴリーの情報が必須であること' do
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it 'カテゴリーの選択肢が---のとき出品できないこと' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '商品の状態についての情報が必須であること' do
      @item.condition_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end

    it '商品の状態について選択肢が---のとき出品できないこと' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition must be other than 1')
    end

    it '配送料の負担についての情報が必須であること' do
      @item.carriage_payer_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Carriage payer can't be blank")
    end

    it '配送料の負担について選択肢が---のとき出品できないこと' do
      @item.carriage_payer_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Carriage payer must be other than 1')
    end

    it '発送元の地域についての情報が必須であること' do
      @item.prefecture_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '発送元の地域について選択肢が---のとき出品できないこと' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '発送までの日数について情報が必須であること' do
      @item.handling_time_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Handling time can't be blank")
    end

    it '発送まで日数について選択肢が---のとき出品できないこと' do
      @item.handling_time_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Handling time must be other than 1')
    end

    it '価格についての情報が必須であること' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が¥300以上であること' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end

    it '価格が¥9,999,999以内であること' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end

    it '販売価格は半角数字のみ保存可能であること' do
      @item.price = '５００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
  end
end
