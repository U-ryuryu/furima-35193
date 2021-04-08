require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      @purchase_address = FactoryBot.build(:purchase_address)
    end

    context '購入できる場合' do
      it 'token,user_id,item_id,postal_code,city,address,tel,prefecture_idが正しく存在していれば登録できること' do
        expect(@purchase_address).to be_valid
      end

      it 'telが11桁以下の数字なら登録できること' do
        @purchase_address.tel = "99999999999"
        expect(@purchase_address).to be_valid
      end
    end

    context '購入者出来ない場合' do
      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では登録できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では登録できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空では登録できないこと' do
        @purchase_address.postal_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeにハイフンがなくては登録できないこと' do
        @purchase_address.postal_code = '1234444'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code requires \"-\"")
      end
      
      it 'postal_codeが3文字-4文字でなくては登録できないこと' do
        @purchase_address.postal_code = '1234-444'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code requires \"-\"")
      end

      it 'cityが空では登録できないこと' do
        @purchase_address.city = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空では登録できないこと' do
        @purchase_address.address = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'telが空では登録できないこと' do
        @purchase_address.tel = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Tel can't be blank")
      end

      it 'telが11桁以上では登録できないこと' do
        @purchase_address.tel = "111111111111"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Tel is too long (maximum is 11 characters)")
      end

      it 'telに全角数字が含まれていると登録できないこと' do
        @purchase_address.tel = "12３45６78９"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Tel only half-width numbers can be entered")
      end

      it 'telに数字以外が含まれていると登録できないこと' do
        @purchase_address.tel = "12as4455"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Tel only half-width numbers can be entered")
      end

      it 'prefecture_idが1では登録できないこと' do
        @purchase_address.prefecture_id = "1"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture please select other than \"---\"")
      end
    end
  end
end
