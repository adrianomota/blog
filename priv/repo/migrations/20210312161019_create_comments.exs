defmodule Blog.Repo.Migrations.CreateComments do
  @moduledoc """

  """
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string

      timestamps()
    end
  end
end
