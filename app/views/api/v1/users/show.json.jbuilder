if @user.valid?
  json.success true
  json.message "User fetched succesfully"
  json.user do
    json.extract! @user, :id, :name, :last_name, :email, :active, :phone, :created_at, :updated_at
  end
else
  json.success false
  json.message @user.errors
end
