require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require'sqlite3'

db = SQLite3::Database.new 'Barbershop.sqlite'
db.execute"CREATE TABLE Users (id integer PRIMARY KEY AUTOINCREMENT,Name varchar,Phone varchar,Datestamp varchar,Barber varchar,Color varchar)"
db.execute"CREATE TABLE Contacts (id integer PRIMARY KEY AUTOINCREMENT,email varchar,message varchar)"
db.close


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]
  @message =" Dear #{@username} ,Phone #{@phone}, we signed up #{@datetime} to the master: #{@barber}"
	# хеш
	hh = { 	:username => 'Введите имя',
			:phone => 'Введите телефон',
			:datetime => 'Введите дату и время' }

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit
	end


	f = File.open"./public/users.txt","a"
	f.write"User: #{@username} Phone: #{@phone} Date and Time: #{@datetime} to the master: #{@barber}\n"
	f.close
	erb :message	
	

	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end

get'/contacts' do
	erb :contact
end

post '/contacts' do
	@email = params[:email]
	@sms = params[:sms]
	@message = "Your Email: #{@email} and sent message: #{@sms}"
	#хеш
	hh = { 	:email => 'Введите Email',
			:sms => 'Введите сообщение',
			 }

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :contact
	end
	f = File.open"./public/contacts.txt","a"
	f.write"User: #{@email} to the message: #{@sms}\n"
	f.close
	erb :message
end 


get'/about' do

	erb :about
end