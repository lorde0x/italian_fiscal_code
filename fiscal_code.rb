# By this Ruby programme you can calculate your italian fiscal code

require 'mysql'

t = '0123456789'
u = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
conversion = [1,0,5,7,9,13,15,17,19,21,2,4,18,20,11,3,6,8,12,14,16,10,22,25,24,23]
i = true

 while i == true do

	puts "What's your name?"
	first_name = gets.chomp.upcase
	
	if first_name[0] == ' ' or first_name.empty? 
		next
	end 

	i = false
 end

i = true

 while  i == true do
	
	puts "What's your last name?"
	last_name = gets.chomp.upcase
	
	if last_name.empty? or last_name[0] == ' '
		next
	end

	 i = false
 end

first_name_vowels = first_name.scan(/[aeiou]/i)
first_name_consonants = first_name.scan(/[^aeiou]/i)
last_name_vowels = last_name.scan(/[aeiou]/i)
last_name_consonants = last_name.scan(/[^aeiou]/i)

	if first_name.scan(/[^aeiou]/i).count == 3 then first_name_consonants[3] = first_name_consonants[2] and first_name_consonants[2] = first_name_consonants[1]
	end

	if first_name.scan(/[^aeiou]/i).count == 2 then first_name_consonants[2] = first_name_consonants[1] and first_name_consonants[3] = first_name_vowels[0]
	end

	if first_name.scan(/[^aeiou]/i).count == 1 then first_name_consonants[2] = first_name_vowels[0] and first_name_consonants[3] = first_name_vowels[1]
	end

	if last_name.scan(/[^aeiou]/i).count == 2 then last_name_consonants[2] = last_name_vowels[0] 
	end

	if last_name.scan(/[^aeiou]/i).count == 1 then last_name_consonants[1] = last_name_vowels[0] and last_name_consonants[2] = last_name_vowels[1]
	end

i = true

 while i == true do

	puts "which year were you born in?"
	year_of_birth = gets.chomp.upcase

	if year_of_birth.empty? or year_of_birth[0] == ' ' 
		next
	end
 
	i = false
 end

months = Hash.new 
months = {
'jenuary' => 'A',
'february' => 'B',
'march' => 'C',
'april' => 'D',
'may' => 'E',
'july' => 'H',
'june' =>'L',
'august' => 'M',
'september' => 'P',
'october' => 'R',
'november' => 'S',
'december' => 'T'  }

i = true

 while i == true do

	puts 'which month were you born?'
	month = gets.chomp

	if month.empty? or month[0] == ' ' 
		next
	end

	if months.include?(month) == false
		next
	end
 
	i = false
 end

i = true

 while i == true do
  
	puts "what gender are you?"
	gender = gets.chomp.upcase
	
	if gender.empty? or gender[0] == ' '  
		next
	end
 
	if gender.downcase == 'male' or  gender.downcase =='female'
		then
	i = false
	end

 end

i = true

 while i == true do

	puts "which day were you born?"
	day = gets.chomp

	if day.empty? or day[0] == ' ' 
		next
	end

	day = day.to_i
	
	if  !day.integer? || day<1 || day>31
		next
	end
	
	if gender.downcase == "female" then day = day.to_i + 40
		elsif day.to_i < 10 then day = '0' + day.to_s
	end

	day = day.to_s
	i = false
 end

i = true
 while i == true do

	puts "where were you born?"
	place = gets.chomp.upcase
	
 begin
	con = Mysql.new 'localhost', 'user', 'password', 'fiscal_code_db'
	h = con.query("select town_code from fiscal_code where town_name = \"#{place}\"")
	j = h.fetch_row
		
 rescue Mysql::Error => e
	puts e.errno
	puts e.errno

 ensure
	con.close if con
 end

	if place.empty? or place[0] == ' ' or j == nil
		next
	end
	i = false
 end

code = "#{last_name_consonants[0]}#{last_name_consonants[1]}#{last_name_consonants[2]}#{first_name_consonants[0]}#{first_name_consonants[2]}#{first_name_consonants[3]}#{year_of_birth[2]}#{year_of_birth[3]}#{months[month]}#{day}#{j[0]}"

w = 0
sum = 0
 
 while w < code.size do

	if w%2==0

		if u.include?(code[w])
			sum += conversion[u.index(code[w])]
		else  
			sum += conversion[t.index(code[w])]
		end

	else
		if u.include?(code[w])
			sum += u.index(code[w])
		else
			sum += code[w].to_i
		end
	end

	w += 1

 end

code += u[sum % 26]

puts "Your fiscal code is: \n#{code}\nThank you for have used my software :))" 
