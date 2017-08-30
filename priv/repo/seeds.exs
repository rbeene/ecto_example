import Example.Factory

admin_company = insert(:company, name: "admin")
large = insert(:company, name: "Initech")
medium = insert(:company, name: "Initrode")

# create administrator of this application
insert(:user, username: "admin", company: admin_company, role: "admin", title: "administrator", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"))

# create managers for large company
bob_1 = insert(:user, username: "slydell", first_name: "Bob", last_name: "Slydell", company: large, role: "admin_manager", title: "consultant", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), gender: "M")
insert(:address, state: "California", user: bob_1)
bob_2 = insert(:user, username: "porter", first_name: "Bob", last_name: "Porter", company: large, role: "manager", title: "consultant", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), gender: "M")
insert(:address, state: "California", user: bob_2)

peter = insert(:user, username: "peter", first_name: "Peter", last_name: "Givens", company: large, role: "direct_report", title: "pm", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), manager: bob_1, gender: "M")
insert(:address, state: "California", user: peter)
michael = insert(:user, username: "michael", first_name: "Michael", last_name: "Bolton", company: large, role: "direct_report", title: "programmer", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), manager: bob_2, gender: "M")
insert(:address, state: "California", user: michael)
samir = insert(:user, username: "samir", first_name: "Samir", last_name: "Nagheenanajar", company: large, role: "direct_report", title: "programmer", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), manager: bob_2, gender: "M")
insert(:address, state: "Indiana", user: samir)


# create manager for medium
manager = insert(:user, username: "manager", company: medium, role: "manager", title: "director", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), gender: "F")
insert(:address, state: "California", user: manager)


# create direct report for manager at medium
steve = insert(:user, username: "steve", first_name: "Steve", last_name: "Jones", company: medium, role: "direct_report", title: "engineer", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), manager: manager, gender: "M")
insert(:address, state: "California", user: steve)
milton = insert(:user, username: "Milton", first_name: "Milton", last_name: "Smith", company: medium, role: "direct_report", title: "programmer", password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"), manager: manager, gender: "M")
insert(:address, state: "California", user: milton)

insert(:appointment, user: milton, type: "massage")
insert(:appointment, user: steve, type: "dentist")
