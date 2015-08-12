defmodule Stripex.Resource do
  defmacro __using__(_) do
    quote location: :keep do
      @resource Module.get_attribute(__MODULE__, :resource) || nil

      def retrieve(ids) when is_tuple(ids) do
        resource_path(ids)
        |> Stripex.get
        |> Stripex.Response.new(@resource)
        |> just_model
      end
      def retrieve(id), do: retrieve({id})
      
      def create, do: create({}, %{})
      def create(ids, list) when is_tuple(ids) and (is_list(list) or is_map(list)) do
        list = Fox.DictExt.shallowify_keys list

        resource_path(ids)
        |> Stripex.post({:form, list}, content_type: "multipart/form-data")
        |> Stripex.Response.new(@resource)
        |> just_model
      end
      def create(id, list), do: create({id}, list)
      def create(id) when is_binary(id) do
        create({id}, %{})
      end
      def create(list), do: create({}, list)

      def all, do: all({}, %{})
      def all(ids, params) when is_tuple(ids) do
        resource_path(ids, params)
        |> Stripex.get
        |> Stripex.Response.new([@resource])
        |> just_model
      end
      def all(ids) when is_tuple(ids) do
        all(ids, %{})
      end
      def all(id) when is_binary(id) or is_integer(id) do
        all({id}, %{})
      end
      def all(params) when is_map(params) or is_list(params) do
        all({}, params)
      end

      def delete(ids) when is_tuple(ids) do
        resource_path(ids)
        |> Stripex.delete
        |> Stripex.Response.kill(@resource)
        |> just_model
      end
      def delete(id), do: delete({id})

      def update(ids, params) when is_tuple(ids) and (is_list(params) or is_map(params)) do
        list = Fox.DictExt.shallowify_keys params

        resource_path(ids)
        |> Stripex.post({:form, list}, content_type: "multipart/form-data")
        |> Stripex.Response.new(@resource)
        |> just_model
      end
      def update(id, params), do: update({id}, params)

      defp just_model(%{model: model}), do: model

      defp resource_path(ids) when is_tuple(ids) do
        @endpoint |> Fox.UriExt.fmt(ids) |> String.replace(~r/\/:id$/, "", global: false)
      end
      defp resource_path(ids, params) when is_tuple(ids) and (is_list(params) or is_map(params)) do
        query_string = Fox.UriExt.encode_query params
        "#{resource_path(ids)}?#{query_string}"
      end
      defp resource_path(params), do: resource_path({}, params)

    end
  end
end
