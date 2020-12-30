require 'rails_helper'

RSpec.describe "記事投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article, user_id: @user.id)
  end
  context '投稿に成功したとき' do
    it '記事投稿に成功すると、トップページに遷移して、新規投稿記事欄に投稿した内容が表示されている' do
      # ログインする
      sign_in(@user)
      # 新規記事投稿画面へ遷移する
      visit new_article_path
      # 値を入力する
      fill_in 'article[title]', with: @article.title
      select @article.category[:name], from: 'article[category_id]'
      fill_in 'article[text]', with: @article.text
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('article[image]', image_path, make_visible: true)
      # 投稿ボタンを押した際に値がDBに保存されていることを確認する
      expect {
        click_on('記事を投稿する')
      }.to change { Article.count }.by(1)
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_selector(".article-image")
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@article.user.nickname)
      expect(page).to have_content(@article.category[:name])
    end
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、投稿に失敗すること' do
      # ログインする
      sign_in(@user)
      # 新規記事投稿画面へ遷移する
      visit new_article_path
      # 値を入力する
      fill_in 'article[title]', with: ""
      fill_in 'article[text]', with: ""
      # 投稿ボタンを押した際に値がDBに保存されていることを確認する
      expect {
        click_on('記事を投稿する')
      }.to change { Article.count }.by(0)
      # 新規投稿ページに遷移していることを確認する
      expect(current_path).to eq articles_path
    end
  end
end


RSpec.describe "記事編集機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id)
  end
  context '編集に成功したとき' do
    it '編集に成功すると、トップページに遷移して、変更した内容が反映されている' do
      # ログインする
      sign_in(@user)
      # 記事詳細画面へ遷移する
      visit article_path(@article)
      # 記事編集画面へ遷移する
      visit edit_article_path(@article)
      # 値を入力する
      @edit_article = FactoryBot.build(:article, user_id: @user.id)
      fill_in 'article[title]', with: @edit_article.title
      select @edit_article.category[:name], from: 'article[category_id]'
      fill_in 'article[text]', with: @edit_article.text
      image_path = Rails.root.join('public/images/test_image2.png')
      attach_file('article[image]', image_path, make_visible: true)
      # 更新ボタンを押す
      click_on('記事を更新する')
      # 記事詳細ページにリダイレクトしていることを確認する
      expect(current_path).to eq article_path(@article)
      # 更新した内容が反映されていることを確認する
      expect(page).to have_selector(".header-img")
      expect(page).to have_content(@edit_article.title)
      expect(page).to have_content(@edit_article.text)
    end
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、投稿に失敗すること' do
      # ログインする
      sign_in(@user)
      # 記事詳細画面へ遷移する
      visit article_path(@article)
      # 記事編集画面へ遷移する
      visit edit_article_path(@article)
      # 誤った情報を入力する
      fill_in 'article[title]', with: ""
      fill_in 'article[text]', with: ""
      # 更新ボタンを押す
      click_on('記事を更新する')
      # 記事編集ページに遷移していることを確認する
      expect(current_path).to eq article_path(@article)
    end
  end
end
