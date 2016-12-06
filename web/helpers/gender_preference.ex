defmodule GenderPreference do
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
