require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品登録できる場合' do
      it 'name,description,price,image,category,status,payment,prefecture,delivery_dayが正しく入力されていれば登録できること' do
        expect(@item).to be_valid
      end

      it 'priceが300〜9,999,999の範囲の半角数字のみなら登録できること(300)' do
        @item.price = '300'
        expect(@item).to be_valid
      end

      it 'priceが300〜9,999,999の範囲の半角数字のみなら登録できること(9,999,999)' do
        @item.price = '9999999'
        expect(@item).to be_valid
      end
    end

    context '商品が登録できない場合' do
      it 'nameが空では登録できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'descriptionが空では登録できないこと' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'priceが空では登録できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが299以下では登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price out of the numerical range')
      end

      it 'priceが10,000,000以上では登録できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price out of the numerical range')
      end

      it 'priceに全角が含まれていると登録できないこと' do
        @item.price = '2５00'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price only half-width numbers can be entered')
      end

      it 'priceに数字以外が含まれていると登録できないこと' do
        @item.price = '2000yen'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price only half-width numbers can be entered')
      end

      it 'imageが空では登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'category_idが1では登録できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category please select other than "---"')
      end

      it 'status_idが1では登録できないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status please select other than "---"')
      end

      it 'payment_idが1では登録できないこと' do
        @item.payment_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Payment please select other than "---"')
      end

      it 'prefecture_idが1では登録できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture please select other than "---"')
      end

      it 'delivery_day_idが1では登録できないこと' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery day please select other than "---"')
      end
    end
  end
end
