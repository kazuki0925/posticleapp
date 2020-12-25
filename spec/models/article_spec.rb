require 'rails_helper'

RSpec.describe Article, type: :model do
  describe Article do
    before do
      @article = FactoryBot.build(:article)
    end

    describe 'ユーザー新規登録' do
      context '記事投稿がうまくいくとき' do
        it '入力画面全ての項目を正しく入力すれば登録できる' do
          expect(@article).to be_valid
        end
        it 'categoryが未選択でも登録できる' do
          @article.category_id = 0
          expect(@article).to be_valid
        end
        it 'imageが未選択でも登録できる' do
          @article.image = nil
          expect(@article).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'titleが空だと登録できない' do
          @article.title = nil
          @article.valid?
          expect(@article.errors.full_messages).to include("Title can't be blank")
        end
        it 'titleが40字より多いと登録できない' do
          over_title = "あ"
          40.times do
            over_title += "あ"
          end
          @article.title = over_title
          @article.valid?
          expect(@article.errors.full_messages).to include("Title is too long (maximum is 40 characters)")
        end
        it 'textが空では登録できない' do
          @article.text = nil
          @article.valid?
          expect(@article.errors.full_messages).to include("Text can't be blank")
        end
        it 'textが15000字より多いと登録できない' do
          over_text = "あ"
          15000.times do
            over_text += "あ"
          end
          @article.text = over_text
          @article.valid?
          expect(@article.errors.full_messages).to include("Text is too long (maximum is 15000 characters)")
        end
      end
    end
  end
end
