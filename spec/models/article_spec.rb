require 'rails_helper'

RSpec.describe Article, type: :model do
  describe Article do
    before do
      @article = FactoryBot.build(:article)
    end

    describe 'ユーザー新規登録' do
      context '記事投稿がうまくいくとき' do
        it '入力画面全ての項目を正しく入力すれば投稿できる' do
          expect(@article).to be_valid
        end
        it 'categoryが未選択でも投稿できる' do
          @article.category_id = 0
          expect(@article).to be_valid
        end
        it 'imageが未選択でも投稿できる' do
          @article.image = nil
          expect(@article).to be_valid
        end
      end

      context '記事投稿がうまくいかないとき' do
        it 'titleが空だと投稿できない' do
          @article.title = nil
          @article.valid?
          expect(@article.errors.full_messages).to include("タイトルを入力してください")
        end
        it 'titleが40字より多いと投稿できない' do
          over_title = "あ"
          40.times do
            over_title += "あ"
          end
          @article.title = over_title
          @article.valid?
          expect(@article.errors.full_messages).to include("タイトルは40文字以内で入力してください")
        end
        it 'textが空では投稿できない' do
          @article.text = nil
          @article.valid?
          expect(@article.errors.full_messages).to include("テキストを入力してください")
        end
        it 'textが15000字より多いと投稿できない' do
          over_text = "あ"
          15000.times do
            over_text += "あ"
          end
          @article.text = over_text
          @article.valid?
          binding.pry
          expect(@article.errors.full_messages).to include("テキストは15000文字以内で入力してください")
        end
      end
    end
  end
end
