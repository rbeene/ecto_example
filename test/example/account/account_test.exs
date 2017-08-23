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
end
