defmodule Example.AccountTest do
  use Example.DataCase

  alias Example.Account

  describe "companies" do
    alias Example.Account.Company

    @valid_attrs %{name: "some name", status: "some status"}
    @update_attrs %{name: "some updated name", status: "some updated status"}
    @invalid_attrs %{name: nil, status: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Account.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Account.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Account.create_company(@valid_attrs)
      assert company.name == "some name"
      assert company.status == "some status"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, company} = Account.update_company(company, @update_attrs)
      assert %Company{} = company
      assert company.name == "some updated name"
      assert company.status == "some updated status"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_company(company, @invalid_attrs)
      assert company == Account.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Account.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Account.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Account.change_company(company)
    end
  end

  describe "users" do
    alias Example.Account.User

    @valid_attrs %{first_name: "some first_name", gender: "some gender", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", gender: "some updated gender", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, gender: nil, last_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.first_name == "some first_name"
      assert user.gender == "some gender"
      assert user.last_name == "some last_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Account.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.first_name == "some updated first_name"
      assert user.gender == "some updated gender"
      assert user.last_name == "some updated last_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "addresses" do
    alias Example.Account.Address

    @valid_attrs %{city: "some city", state: "some state", street: "some street", zip: "some zip"}
    @update_attrs %{city: "some updated city", state: "some updated state", street: "some updated street", zip: "some updated zip"}
    @invalid_attrs %{city: nil, state: nil, street: nil, zip: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Account.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Account.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Account.create_address(@valid_attrs)
      assert address.city == "some city"
      assert address.state == "some state"
      assert address.street == "some street"
      assert address.zip == "some zip"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, address} = Account.update_address(address, @update_attrs)
      assert %Address{} = address
      assert address.city == "some updated city"
      assert address.state == "some updated state"
      assert address.street == "some updated street"
      assert address.zip == "some updated zip"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_address(address, @invalid_attrs)
      assert address == Account.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Account.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Account.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Account.change_address(address)
    end
  end
end
