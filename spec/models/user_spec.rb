require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、family_nameとfirst_name、family_name_kanaとfirst_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'emailに@が含まれない場合登録できない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは半角英数字混合で入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは半角英数字混合で入力してください")
      end
      it 'passwordが半角数字のみだと登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end
      it 'passwordが半角英字のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが存在してもpassword_confirmationが一致していなければ登録できない' do
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end
      it 'family_nameが半角では登録できない' do
        @user.family_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は全角（漢字・ひらがな・カタカナ）文字を使用してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角（漢字・ひらがな・カタカナ）文字を使用してください")
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角（漢字・ひらがな・カタカナ）文字を使用してください')
      end
      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)を入力してください", "苗字(カナ)は全角（カタカナ）文字を使用してください")
      end
      it 'family_name_kanaが全角ひらがなでは登録できない' do
        @user.family_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は全角（カタカナ）文字を使用してください')
      end
      it 'family_name_kanaが漢字では登録できない' do
        @user.family_name_kana = '一'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は全角（カタカナ）文字を使用してください')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください", "名前(カナ)は全角（カタカナ）文字を使用してください")
      end
      it 'first_name_kanaが全角ひらがなでは登録できない' do
        @user.first_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)は全角（カタカナ）文字を使用してください')
      end
      it 'first_name_kanaが漢字では登録できない' do
        @user.first_name_kana = '一'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)は全角（カタカナ）文字を使用してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
