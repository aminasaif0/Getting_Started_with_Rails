class SetDefaultState < ActiveRecord::Migration[7.1]
  def change
    change_column_default :articles, :state, 'active'
  end
end
