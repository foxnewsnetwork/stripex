defmodule Stripex.Error do
  defexception [:message]

  def exception(c) do
    %Stripex.Error{ message: "Strip responded with status code: #{c}" }
  end
end