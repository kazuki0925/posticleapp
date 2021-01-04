require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it '入力画面全ての項目を正しく入力すれば登録できる' do
          expect(@user).to be_valid
        end
        it 'passwordが6文字以上であれば登録できる' do
          @user.password = '123abc'
          @user.password_confirmation = '123abc'
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nicknameが空だと登録できない' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームを入力してください")
        end
        it 'emailが空では登録できない' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールを入力してください")
        end
        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
        end
        it 'emailに＠が含まれていない場合は登録できない' do
          @user.email = 'test.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Eメールは不正な値です')
        end
        it 'passwordが空では登録できない' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードを入力してください")
        end
        it 'passwordが5文字以下であれば登録できない' do
          @user.password = '123ab'
          @user.password_confirmation = '123ab'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
        end
        it 'passwordは半角数字だけでは登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは英数字混合で入力してください')
        end
        it 'passwordは半角英語だけでは登録できない' do
          @user.password = 'aaaaaa'
          @user.password_confirmation = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは英数字混合で入力してください')
        end
        it 'passwordが存在してもpassword_confirmationが空では登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end
        it 'passwordとpassword_confirmationが一致していないと登録できない' do
          @user.password = '123abc'
          @user.password_confirmation = 'abc123'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end
      end
    end
  end
end
