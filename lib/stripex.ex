defmodule Stripex do
  use Gateway, [{:Authorization, :secret_key}]
end
