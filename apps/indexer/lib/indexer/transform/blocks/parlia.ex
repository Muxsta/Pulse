defmodule Indexer.Transform.Blocks.Parlia do
  @moduledoc """
  Handles block transforms for PulseChain.
  """

  alias Indexer.Transform.Blocks

  @behaviour Blocks

  @impl Blocks
  def transform(%{number: 0} = block), do: block

  def transform(block) when is_map(block) do
    pulse_fork_block = Application.get_env(:indexer, :pulse_fork_block)

    if  block.number >= pulse_fork_block do
      miner_address = Blocks.signer(block)

      %{block | miner_hash: miner_address}
    else
      block
    end
  end
end
