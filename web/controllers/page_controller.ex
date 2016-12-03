defmodule Rmo.PageController do
  use Rmo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
