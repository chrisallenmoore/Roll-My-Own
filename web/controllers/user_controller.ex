defmodule Rmo.UserController do
  use Rmo.Web, :controller

  alias Rmo.User
  alias Rmo.QueryFilter

  #def index(conn, _params) do
    #users = Repo.all(User)
    #render(conn, "index.html", users: users)
  #end

  def index(conn, params) do

    #%{ "gender_preference" => gender_preference, "status" => status } = _params



    users =
      Rmo.User
      #|> where([p], p.gender == ^gender_preference)
      #|> where([p], p.status == ^status)
      |> QueryFilter.filter(%User{}, params, [:gender_preference, :status])
      |> order_by(desc: :updated_at)
      #|> Rmo.Repo.all()
      |> Rmo.Repo.paginate(params)

    render conn, :index,
      users: users
      #page_number: page.page_number,
      #page_size: page.page_size,
      #total_pages: page.total_pages,
      #total_entries: page.total_entries
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
