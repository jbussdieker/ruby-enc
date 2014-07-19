class AddAgentStatusToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :agent_status, :string
  end
end
