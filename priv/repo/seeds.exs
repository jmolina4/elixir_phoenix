# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
alias Dogfamily.Repo
alias Dogfamily.Role
alias Dogfamily.User
alias Dogfamily.Registration

Repo.delete_all(Role)
Repo.delete_all(User)

role = Repo.insert!(%Role{:name => "admin", :admin => true})

changeset = User.changeset(%User{}, %{email: "javi.ms10@gmail.com", password: "123456", role_id: role.id})
case Registration.create(changeset, Repo) do
  {:ok, _user} ->
    IO.puts('ok')
  {:error, changeset} ->
    IO.puts(changeset)
end
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
