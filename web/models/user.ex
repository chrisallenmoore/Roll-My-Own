defmodule Rmo.User do
  use Rmo.Web, :model

  schema "users" do
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :date_of_birth, Ecto.Date
    field :gender, :string
    field :gender_preference, :string
    field :status, :string
    field :location, :string
    field :description, :string

    timestamps
  end

  @required_fields [:email, :password, :username, :date_of_birth, :gender, :gender_preference, :status]
  @optional_fields [:first_name, :last_name, :location, :description]
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_confirmation(:password)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end

end
