class AddRawDefaultToState < ActiveRecord::Migration
  def up
    change_column_default :article_versions, :state, 'Raw'
  end

  def down
    change_column_default :article_versions, :state, nil
  end
end
