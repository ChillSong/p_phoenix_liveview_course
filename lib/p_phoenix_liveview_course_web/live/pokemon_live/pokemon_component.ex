defmodule PPhoenixLiveviewCourseWeb.PokemonLive.PokemonComponent do
  use Phoenix.Component

  attr :pokemon, :map, required: true

  def pokemon_card(assigns) do
    assigns =
      assigns
      |> assign(
        label_type:
          case assigns.pokemon.type do
            :fire -> "Fire 🔥"
            :water -> "Water 💧"
            :grass -> "Grass 🌱"
          end
      )

    ~H"""
    <div class="pokemon-card">
      <img src={@pokemon.image_url} alt={@pokemon.name} />
      <h2>{@pokemon.name}</h2>
      <p>Type: {@label_type}</p>
    </div>
    """
  end
end
