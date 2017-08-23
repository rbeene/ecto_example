defmodule ExampleWeb.AddressView do
  use ExampleWeb, :view
  alias ExampleWeb.AddressView

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{id: address.id,
      street: address.street,
      city: address.city,
      zip: address.zip,
      state: address.state}
  end
end
