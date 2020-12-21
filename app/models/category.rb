class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '政治・経済' },
    { id: 2, name: '旅行' },
    { id: 3, name: 'ライフスタイル' },
    { id: 4, name: '恋愛' },
    { id: 5, name: 'IT' },
    { id: 6, name: 'エンタメ' },
    { id: 7, name: 'スポーツ' },
    { id: 8, name: 'グルメ' },
    { id: 9, name: '趣味' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :articles

end