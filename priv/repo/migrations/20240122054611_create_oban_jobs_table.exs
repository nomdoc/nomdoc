defmodule Nomdoc.Repo.Migrations.CreateObanJobsTable do
  use Ecto.Migration

  def up do
    Oban.Migration.up()
  end

  # We specify `version: 1` in `down`, ensuring that we'll roll all the way back down if
  # necessary, regardless of which version we've migrated `up` to.
  def down do
    Oban.Migration.down(version: 1)
  end
end
