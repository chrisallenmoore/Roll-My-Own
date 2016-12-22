defmodule Rmo.UserController do
  use Rmo.Web, :controller

  alias Rmo.User
  alias Rmo.QueryFilter

  def index(conn, params) do
    users =
      Rmo.User
      |> QueryFilter.filter(%User{}, params, [:gender_preference, :status])
      |> order_by(desc: :updated_at)
      |> Rmo.Repo.paginate(params)

    render conn, :index,
      users: users,
      gender_preference: params["gender_preference"],
      status: params["status"]
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

end
