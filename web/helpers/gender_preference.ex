defmodule GenderPreference do
  @moduledoc """
  This module determines a user's status using their gender and gender_preference
  """
  def match(gender,gender_preference) do

    if gender === "M" do
      cond do
        gender !== gender_preference ->
          "Straight"
        gender === gender_preference ->
          "Gay"
      end
    else gender === "F"
      cond do
        gender !== gender_preference ->
          "Straight"
        gender === gender_preference ->
          "Lesbian"
      end

    end

  end

end
