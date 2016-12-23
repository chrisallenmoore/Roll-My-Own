defmodule Rmo.UserController do
  use Rmo.Web, :controller

  alias Rmo.User
  alias Rmo.QueryFilter

  @doc """
  Get value of :current_user from session, return the value\n
  If no current user, return value of 0 for the current_user id
  """
  def get_current_user(conn, params) do
    if Plug.Conn.get_session(conn, :current_user) do
       Plug.Conn.get_session(conn, :current_user)
     else
       0
    end
  end

  def index(conn, params) do

    current_user = get_current_user(conn, params)

    users =
      Rmo.User
      |> QueryFilter.filter(%User{}, params, [:gender_preference, :status])
      |> where( [u], u.id != ^current_user )
      #TODO: make the query eliminate current_user from results
      #TODO: set query to only search for your gender_preference and show the user if their preference is your gender
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
