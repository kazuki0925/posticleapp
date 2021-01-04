require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe Comment do
    before do
      @comment = FactoryBot.build(:comment)
    end

    describe 'コメント投稿' do
      context 'コメント投稿がうまくいくとき' do
        it '入力画面全ての項目を正しく入力すれば投稿できる' do
          expect(@comment).to be_valid
        end
      end

      context 'コメント投稿がうまくいかないとき' do
        it 'textが空だと投稿できない' do
          @comment.text = nil
          @comment.valid?
          expect(@comment.errors.full_messages).to include("Textを入力してください")
        end
        it 'textが2000字より多いと投稿できない' do
          over_text = "あ"
          2000.times do
            over_text += "あ"
          end
          @comment.text = over_text
          @comment.valid?
          expect(@comment.errors.full_messages).to include("Textは2000文字以内で入力してください")
        end
      end
    end
  end
end
