require 'rails_helper'

RSpec.describe "コメント投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
    @comment = FactoryBot.build(:comment, user_id: @user.id)
  end
  context '投稿に成功したとき' do
    it '記事投稿に成功すると、トップページに遷移して、新規投稿記事欄に投稿した内容が表示されている' do
      # ログインする
      sign_in(@user)
      # 新規記事投稿画面へ遷移する
      visit article_path(@article)
      # 値を入力する
      fill_in 'comment[text]', with: @comment.text
      # 投稿ボタンを押した際に値がDBに保存されていることを確認する
      expect {
        click_on('コメントを送信')
      }.to change { Comment.count }.by(1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq article_path(@article)
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@comment.user.nickname)
    end
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、投稿に失敗すること' do
      # ログインする
      sign_in(@user)
      # 新規記事投稿画面へ遷移する
      visit article_path(@article)
      # 値を入力する
      fill_in 'comment[text]', with: ""
      # 投稿ボタンを押した際に値がDBに保存されていることを確認する
      expect {
        click_on('コメントを送信')
      }.to change { Comment.count }.by(0)
      # 詳細ページに遷移していることを確認する
      expect(current_path).to eq article_comments_path(@article)
      # 送信した値がブラウザに表示されていないことを確認する
      expect(page).to have_no_content(@comment.text)
      expect(page).to have_no_selector(".comment-user-name")
    end
  end
end