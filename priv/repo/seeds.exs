# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
alias Dogfamily.Repo
alias Dogfamily.User
alias Dogfamily.Role
alias Dogfamily.Registration

Repo.delete_all(Role)
Repo.delete_all(User)

Repo.insert!(%Role{:name => "Admin", :admin => true})

changeset = User.changeset(%User{}, %{:email => "javi.ms10@gmail.com", :password => "123456", :role_id => 1})
Registration.create(changeset, Repo)
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
