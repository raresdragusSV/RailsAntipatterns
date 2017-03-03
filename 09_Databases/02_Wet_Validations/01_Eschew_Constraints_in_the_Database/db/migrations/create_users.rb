class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.column :email, :string, null: false
      t.column :first_name, :string, null: false
      t.column :last_name, :string, null: false
      t.column :password, :string
      t.column :account_id, :integer
    end
    execute <<-SQL
      ALTER TABLE users ADD UNIQUE (email)
    SQL
    execute <<-SQL
      ALTER TABLE users ADD CONSTRAINT
      user_constrained_by_account FOREIGN KEY (account_id) REFERENCES
      accounts (id) ON DELETE CASCADE
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE users DROP FOREIGN KEY
      user_constrained_by_account
    SQL
    drop_table :users
  end
end
