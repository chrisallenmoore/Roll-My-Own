defmodule Rmo.User do
  use Rmo.Web, :model

  schema "users" do
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true

    timestamps
    @required_fields ~w(email password)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end
end
