class AddDefaultAdmin < ActiveRecord::Migration[5.2]
  def change
    admin = User.new(
      is_admin: true,
      name: 'admin',
      email: 'admin123@some.com',
      password: 'admin123'
    )
    admin.save

    user = User.new(
      is_admin: false,
      name: 'test',
      email: 'test@some.com',
      password: '123456'
    )
    user.save
  end
end
