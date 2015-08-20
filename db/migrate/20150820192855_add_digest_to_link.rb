class AddDigestToLink < ActiveRecord::Migration
  def up
    add_column :links, :digest, :string, null: true

    Link.update_all(digest: Weekly::Digest::PROGRAMMING)
  end
end
