task :auto_done do
  require 'date'
  # connection = ActiveRecord::Base.establish_connection(
  #   :adapter  => "mysql2",
  #   :host     => "localhost",
  #   :username => "root",
  #   :password => "root",
  #   :database => "coffeshop_system_rails_development"
  # )
  connection = ActiveRecord::Base.establish_connection(
    :adapter  => "postgresql",
    :host     => "ec2-54-163-252-55.compute-1.amazonaws.com",
    :username => "rplmbohhvbpuzr",
    :password => "febd229ae332855790e7e12e93379a29329486fde65590539394bc27f10194c3",
    :database => "db1r56gi21e92e"
  )
  @connection = ActiveRecord::Base.connection

  result = @connection.exec_query('SELECT * FROM orders where status="Out For Delivery"')
  result.each do |row|
     if row['created_at'].to_datetime < 10.minute.ago
        @connection.exec_query('UPDATE orders SET status="Done" where id='+row['id'].to_s)
     end
  end
end
