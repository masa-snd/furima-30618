require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemail、passwordとpassword_confirmation、family_nameとfirst_name、family_name_kanaとfirst_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        # another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailに@が含まれない場合登録できない" do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが半角英数字混合での入力されていなければ登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 半角英数字混合で入力してください")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが存在してもpassword_confirmationが一致していなければ登録できない" do
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "family_nameが空では登録できない" do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name 全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end
      it "family_nameが半角では登録できない" do
        @user.family_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name 全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end
      it "first_nameが半角では登録できない" do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end
      it "family_name_kanaが空では登録できない" do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", "Family name kana 全角（カタカナ）文字を使用してください")
      end
      it "family_name_kanaが全角ひらがなでは登録できない" do
        @user.family_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana 全角（カタカナ）文字を使用してください")
      end
      it "family_name_kanaが漢字では登録できない" do
        @user.family_name_kana = '一'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana 全角（カタカナ）文字を使用してください")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana 全角（カタカナ）文字を使用してください")
      end
      it "first_name_kanaが全角ひらがなでは登録できない" do
        @user.first_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角（カタカナ）文字を使用してください")
      end
      it "first_name_kanaが漢字では登録できない" do
        @user.first_name_kana = '一'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角（カタカナ）文字を使用してください")
      end
      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end