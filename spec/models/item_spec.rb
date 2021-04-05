require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品登録できる場合' do
      it '' do
        
      end

    end

    context '商品が登録できない場合' do
      it '' do
        
      end

    end
  end
end
