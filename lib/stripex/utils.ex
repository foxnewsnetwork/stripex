defmodule Stripex.Utils do

  @spec safe_atomize_keys(map, list(atom)) :: map
  @doc """
  Return a map with all keys converted to atoms given in the list. Skips all
  other atoms
  """
  def safe_atomize_keys(map, safe_keys) when is_map(map) do
    for safe_key <- safe_keys, into: %{} do
      string_key = Atom.to_string(safe_key)
      value = Map.get(map, string_key)
      { safe_key, value }
    end
  end
end
