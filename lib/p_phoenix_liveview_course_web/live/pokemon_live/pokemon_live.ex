defmodule PPhoenixLiveviewCourseWeb.PokemonLive.Pokemon do
  defstruct name: "", type: nil, image_url: ""
end

defmodule PPhoenixLiveviewCourseWeb.PokemonLive do
  use PPhoenixLiveviewCourseWeb, :live_view
  alias PPhoenixLiveviewCourseWeb.PokemonLive.Pokemon
  alias PPhoenixLiveviewCourseWeb.PokemonLive.PokemonComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> init_pokemons()}
  end

  #  PRIVATES
  defp init_pokemons(socket) do
    charmander = %Pokemon{
      name: "Charmander",
      type: :fire,
      image_url: ~p"/images/charmander.png"
    }

    squirtle = %Pokemon{name: "Squirtle", type: :water, image_url: ~p"/images/squirtle.png"}
    bulbasaur = %Pokemon{name: "Bulbasaur", type: :grass, image_url: ~p"/images/bulbasaur.png"}

    available_pokemons = [charmander, squirtle, bulbasaur]
    socket |> assign(pokemons: available_pokemons)
  end
end
