# テーブル設計

## usersテーブル

| Column                | Type    | Options                   |
|-----------------------|---------|---------------------------|
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false               |
| nickname              | string  | null: false               |

### Association

- has_many :articles
- has_many :comments
- has_many :favorites


## articlesテーブル

| Column                | Type       | Options           |
|-----------------------|------------|-------------------|
| title                 | string     | null: false       |
| text                  | text       | null: false       |
| user                  | references | foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :favorites


## commentsテーブル

| Column                | Type       | Options           |
|-----------------------|------------|-------------------|
| text                  | text       | null: false       |
| user                  | references | foreign_key: true |
| article               | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :article


## favoriteテーブル

| Column  | Type       | Options           |
|---------|------------|-------------------|
| user    | references | foreign_key: true |
| article | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :article