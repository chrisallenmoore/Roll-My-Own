defmodule Rmo.Repo do
  use Ecto.Repo, otp_app: :rmo
  use Scrivener, page_size: 2
end
