class DeviseCreateUsuarios < ActiveRecord::Migration

  def up
    create_table(:usuarios) do |t|
      
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
      t.string   :nome
      t.string   :grupo, :default => 'usuario'
      t.string   :matricula
      t.string   :cloud_token
      t.string   :turma
      t.boolean  :change_password

      t.timestamps
    end

    add_index :usuarios, :email, :unique => true

    Usuario.create(:nome => 'Administrador Geral', :email => "admin@#{AppAdmin.domain}", :grupo => :admin, :password => '123mudar', :password_confirmation => '123mudar', :change_password => true)
  end

  def down
    drop_table :usuarios
  end

end
