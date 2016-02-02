class CreateAccountsAndUsers < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name, limit: 255, null: false
      t.integer :status, null: false , default: 0
      t.integer :flags, null: false, default: 0
      t.integer :lock_version, null: false, default: 0
      t.timestamps null: false
    end

    add_index :accounts, :name, unique: true

    create_table :users do |t|
      t.string :name, limit: 255, null: false
      t.string :email, limit: 255, null: true
      t.column :password_hash, :binary, limit: 255, null: false
      t.integer :status, null: false , default: 0
      t.integer :flags, null: false, default: 0

      t.integer :lock_version, null: false, default: 0
      t.timestamps null: false
    end

    add_index :users, :name, unique: true
    add_index :users, :email

    create_table :account_user_roles do |t|
      t.references :account, null: false
      t.references :user, null: false
      t.integer :relation, null: false, default: 0
      t.integer :status, null: false , default: 0
      t.integer :flags, null: false, default: 0

      t.timestamps null: false
    end

    add_index :account_user_roles, [:account_id, :user_id], unique: true
    add_index :account_user_roles, [:user_id, :account_id]

    create_table :validation_tokens do |t|
      t.binary :token, limit: 255, null: false
      t.references :account, null: true
      t.references :user, null: true
      t.integer :category, null: false
      t.datetime :valid_until, null: true

      t.timestamps null: false
    end

    add_index :validation_tokens, :token, unique: true

  end
end
