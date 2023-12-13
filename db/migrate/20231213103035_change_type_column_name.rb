class ChangeTypeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :type, :state
  end
end
