class CreateBadEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :bad_evaluations do |t|
      t.references :user,    foreign_key: true
      t.references :article, foreign_key: true
      t.timestamps
    end
  end
end
