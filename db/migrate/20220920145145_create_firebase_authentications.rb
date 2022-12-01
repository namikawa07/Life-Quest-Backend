class CreateFirebaseAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :firebase_authentications do |t|
      t.integer    :status,            null: false, unsigned: true, limit: 5
      t.integer    :sign_in_provider,  null: false, unsigned: true, limit: 5
      t.references :user,              null: false
      t.string     :uid,               null: false, collation: 'utf8mb4_bin'
      t.string     :email,             null: false, collation: 'utf8mb4_bin'
      t.text       :refresh_token,     null: false
      t.text       :access_token,      null: true
      t.text       :id_token,          null: false
      t.string     :tenant_id,         null: true, collation: 'utf8mb4_bin'
      t.boolean    :email_verified,    null: false, default: false

      t.timestamps
    end
  end
end
