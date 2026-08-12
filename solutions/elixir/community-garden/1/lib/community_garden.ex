# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(
      fn -> %{plots: [], next_id: 1} end,
      opts
    )
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, registered_to) do
    Agent.get_and_update(pid, fn state ->
      plot = %Plot{
        plot_id: state.next_id,
        registered_to: registered_to
      }
  
      new_state = %{
        plots: [plot | state.plots],
        next_id: state.next_id + 1
      }
  
      {plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      plots =
        Enum.reject(state.plots, fn plot ->
          plot.plot_id == plot_id
        end)
  
      %{state | plots: plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(
        state.plots,
        {:not_found, "plot is unregistered"},
        fn plot -> plot.plot_id == plot_id end
      )
    end)
  end
end
