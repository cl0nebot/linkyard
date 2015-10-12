class AddDigestToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :digest, :string, null: true
  end
end
