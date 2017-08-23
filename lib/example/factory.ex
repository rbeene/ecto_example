defmodule Example.Factory do
  use ExMachina.Ecto, repo: Example.Repo
  alias Example.Account
  alias Example.Activity

  def company_factory do
    %Account.Company{
      name: Faker.Company.name,
      status: "active"
    }
  end

  def user_factory do
    first = Faker.Name.first_name
    %Account.User{
      username: first |> String.downcase(),
      first_name: first,
      last_name: Faker.Name.last_name,
      status: "active",
      gender: Enum.random(~w(M F)),
      role: "direct_report",
      password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"),
      company: build(:company)
    }
  end

  def address_factory do
    %Account.Address{
      street: Faker.Address.street_address,
      city: Faker.Address.city,
      state: Faker.Address.state,
      zip: Faker.Address.zip_code,
      user: build(:user)
    }
  end

  def appointment_factory do
    %Activity.Appointment{
      type: Enum.random(~w(Chiropractor Dentist Optometrist)),
      user: build(:user)
    }
  end
end
