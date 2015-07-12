# italian_fiscal_code

This is a Ruby programme that calculate your italian fiscal code.
Before running it you need to populate your database with town codes related to communes.

1) Go to "http://statistica.regione.emilia-romagna.it/primo-piano/elenco_comuni_italiani_1gennaio_2014.xls" and create a CSV file containing two columns taken by fields "codice catastale" and "solo denominazione in italiano".

2) Create a database called "fiscal_code_db" and then populate it following this guide "http://stackoverflow.com/questions/2783313/how-can-i-get-around-mysql-errcode-13-with-select-into-outfile" (answer 11).

3) Go to "https://dev.mysql.com/doc/refman/5.5/en/load-data.html" to make sure you're using the correct syntax.

Make sure you have installed mysql gem typing:

"gem install mysql"

4)The program uses the following data for MySql access: 

  	user: user

  	pass: password

so create a user like this typing:

	CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';

or change the source code where needed to use a different user.

5)Make sure that the user has permissions to read the database: 

GRANT ALL ON doc_db.* to script@localhost;

Finally you can use this programme and calculate whatever fiscal_code you want : enjoy it!!
