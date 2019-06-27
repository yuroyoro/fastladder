class AddTopnIndexToItems < ActiveRecord::Migration
  def change
    add_index(:items, [:feed_id, :created_on, :id], name: :idx_items_topN, order: { created_on: :desc, id: :desc })
  end
end
