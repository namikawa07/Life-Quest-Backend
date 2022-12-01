class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string   :uuid,               null: false,                 limit: 50, collation: 'utf8mb4_bin'
      t.integer  :status,             null: false, unsigned: true, limit: 5
      t.string   :name,               null: false,                 limit: 191, collation: 'utf8mb4_bin'
      t.text     :self_introduction,  null: true
      t.text     :thumbnail_url,      null: true
      t.string   :email,              null: true,                  limit: 191, collation: 'utf8mb4_bin'
      t.string   :uid,                null: false, collation: 'utf8mb4_bin'

      t.timestamps
    end
  end
end
