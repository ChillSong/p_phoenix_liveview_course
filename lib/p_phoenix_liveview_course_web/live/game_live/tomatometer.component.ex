defmodule PPhoenixLiveviewCourseWeb.GameLive.Tomatometer do
  use PPhoenixLiveviewCourseWeb, :live_component
  alias PPhoenixLiveviewCourseWeb.GameLive.GameComponent
  alias PPhoenixLiveviewCourse.Rating
  alias PPhoenixLiveviewCourse.Rating.Tomatoes

  @impl true
  def update(assigns, socket) do
    {:ok, socket |> assign(assigns) |> assign_tomatoes_rating(assigns.game.id)}
  end

  @impl true
  def handle_event("on_tomatoe", %{"count" => count, "type" => type}, socket) do
    new_count = String.to_integer(count) + 1
    type = String.to_atom(type)
    current_tomatoes = socket.assigns.tomatoes

    case Rating.update_tomatoes(current_tomatoes, Map.put(%{}, type, new_count)) do
      {:ok, updated_tomatoes} ->
        {:noreply, socket |> assign(:tomatoes, updated_tomatoes)}

      _error ->
        {:noreply, socket |> put_flash(:error, "Cannot update tomatoes info")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-center items-center gap-4">
      <GameComponent.tomatoe_button
        type={:good}
        count={@tomatoes.good}
        game_id={@game.id}
        on_tomatoe={{"on_tomatoe", @myself}}
      />
      <GameComponent.tomatoe_button
        type={:bad}
        count={@tomatoes.bad}
        game_id={@game.id}
        on_tomatoe={{"on_tomatoe", @myself}}
      />
      <GameComponent.tomatoes_score good={@tomatoes.good} bad={@tomatoes.bad} />
    </div>
    """
  end

  ## PRIVATES
  defp assign_tomatoes_rating(socket, game_id) do
    case Rating.get_tomatoes_by_game(game_id) do
      %Tomatoes{} = tomatoes ->
        socket |> assign(:tomatoes, tomatoes)

      _ ->
        socket |> put_flash(:error, "Cannot get tomatoes info")
    end
  end
end
