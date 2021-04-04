class RollbackMigrations < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :result, :string
    change_column :invoices, :status, :string

  end
end
