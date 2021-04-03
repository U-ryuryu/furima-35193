require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    it "ickname,email,password,password_confirmation,last_name,first_name,read_last_name,read_first_name,birthdayが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nicknameが空では登録できないこと" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できないこと" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "passwordが空では登録できないこと" do
      @user.password = ""
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "last_nameが空では登録できないこと" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "first_nameが空では登録できないこと" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "read_last_nameが空では登録できないこと" do
      @user.read_last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Read last name can't be blank")
    end

    it "read_first_nameが空では登録できないこと" do
      @user.read_first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Read first name can't be blank")
    end

    it "birthdayが空では登録できないこと" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it "passwordが6文字以上で英数字混合であれば登録できること" do
      @user.password = "abc123"
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "ab123"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordが数字のみでは登録できないこと" do
      @user.password = "123456"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Use both English and numbers")
    end

    it "passwordが英字のみでは登録できないこと" do
      @user.password = "abcdef"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Use both English and numbers")
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "abc123"
      @user.password_confirmation = "123abc"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "last_nameが全角かな/カナ漢字であれば登録できること" do
      @user.last_name = "あア漢字ー"
      expect(@user).to be_valid
    end

    it "last_nameに半角文字があれば登録できないこと" do
      @user.last_name = "あｱ漢字"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name Please enter full-width Japanese")
    end

    it "first_nameが全角かな/カナ漢字であれば登録できること" do
      @user.first_name = "あア漢字ー"
      expect(@user).to be_valid
    end

    it "first_nameに半角文字があれば登録できないこと" do
      @user.first_name = "あｱ漢字"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Please enter full-width Japanese")
    end

    it "read_last_nameが全角カタカナのみであれば登録できること" do
      @user.read_last_name = "カナカナ"
      expect(@user).to be_valid
    end

    it "read_last_nameに全角カタカナ意外があれば登録できないこと" do
      @user.read_last_name = "かなカナ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Read last name Please enter in the full-width katakana")
    end

    it "read_first_nameが全角カタカナのみであれば登録できること" do
      @user.read_first_name = "カナカナ"
      expect(@user).to be_valid
    end

    it "read_first_nameに全角カタカナ意外があれば登録できないこと" do
      @user.read_first_name = "かなカナ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Read first name Please enter in the full-width katakana")
    end

    it "emailは@の前後に英数字を含んでいれば登録できること" do
      @user.email = "abc@123"
      expect(@user).to be_valid
    end

    it "emailは先頭が@では登録でないこと" do
      @user.email = "@abc@123"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "emailは最後の文字がが@では登録でないこと" do
      @user.email = "abc@123@"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "emailは@が含まれていなければ登録でないこと" do
      @user.email = "abc123"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      anather_user = FactoryBot.build(:user, email: @user.email)
      anather_user.valid?
      expect(anather_user.errors.full_messages).to include("Email has already been taken")
    end
  end
end
