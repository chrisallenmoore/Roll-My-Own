defmodule Rmo.RegistrationController do
  use Rmo.Web, :controller
  alias Rmo.User

  def new(conn, _parmas) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Rmo.Registration.create(changeset, Rmo.Repo) do
      {:ok, changeset} ->
        # sign in the user
        conn
          |> put_session(:current_user, changeset.id)
          |> put_flash(:info, "Your account was created")
          |> redirect(to: "/")
      {:error, changeset} ->
        #show error message
        conn
          |> put_flash(:info, "Unable to create account")
          |> render("new.html", changeset: changeset)
    end
  end
end
