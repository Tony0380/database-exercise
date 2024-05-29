The table "testate" is composed of the following attributes:
- idTestata: a four-character alphanumeric code
- nome: a text of 20 characters
- redazione: a four-character alphanumeric code

The table "redattori" is composed of the following attributes:
- idRedattori: a three-character alphanumeric code
- cognome: a text of 10 characters
- nome: a text of 8 characters
- via: a text of 15 characters
- citta: a text of 15 characters
- provincia: a textual code of 2 characters
- CAP: a text of 5 characters
- email: a text

The table "redazioni" is composed of the following attributes:
- idRedazione: a four-character alphanumeric code
- nomeComitato: a text of 10 characters
- citta: a text of 8 characters
- indirizzoWeb: a text

The table "redazRedat" is composed of the following attributes:
- idRedazione: a four-character alphanumeric code
- idRedattori: a three-character alphanumeric code

The table "categorie" is composed of the following attributes:
- nomeCategoria: a text of 10 alphanumeric characters
- categoriaPadre: a text of 10 alphanumeric characters

The table "inserzioni" is composed of the following attributes:
- codice: a text of 6 alphanumeric characters
- testo: a text
- categoria: a text of 10 alphanumeric characters

The table "instest" is composed of the following attributes:
- idInserzione: a text of 6 alphanumeric characters
- idTestata: a four-character alphanumeric code

The table "aziende" is composed of the following attributes:
- idAzienda: a six-character alphanumeric code
- nomeAzienda: a text of 40 characters
- referente: a text of 40 characters
- telefono: a text of 11 characters
- citta: a text of 15 characters
- provincia: a textual code of 2 characters
- via: a text of 15 characters
- CAP: a text of 5 characters
- CapitaleSociale: an integer

The table "insaz" is composed of the following attributes:
- idAzienda: a six-character alphanumeric code
- idInserzione: a text of 6 alphanumeric characters

The table "privati" is composed of the following attributes:
- idPrivato: a three-character alphanumeric code
- cognome: a text of 10 characters
- nome: a text of 8 characters
- via: a text of 15 characters
- citta: a text of 15 characters
- provincia: a textual code of 2 characters
- CAP: a text of 5 characters
- email: a text

The table "inspriv" is composed of the following attributes:
- idPrivato: a six-character alphanumeric code
- idInserzione: a text of 6 alphanumeric characters

Part 2:

After completing the previous exercise, continue editing the .sql file and insert data into the database. Follow the following instructions:

1. To insert into the database at least three newspaper headers;
2. To modify the size of the name and surname of individuals to a text of 30 characters using the ALTER TABLE statement;
3. To create the "cities" table with attributes: city, province, and ZIP code, where ZIP code is the primary key;
4. To modify the tables where the attribute "city" is present so that they have a foreign key to the "cities" table instead of the three separate attributes;
5. To insert into the database as many editorial committees as there are newspaper headers inserted;
6. To insert into the database a number of people who make up the editorial committees, taking into account that some editors may be part of multiple committees;
7. To modify the "categories" table so that the primary key is "categoryId" instead of "categoryName";
8. To insert the categories, each with a different number of subcategories (e.g., rentals and sales are subcategories of houses);
9. To insert at least 10 private ads and 10 company ads into the tables;
10. To verify that the data has been inserted correctly, particularly by performing simple queries (e.g., SELECT * FROM tableName;) on the tables where the data was inserted as soon as the insertion is complete;
11. Constraints, insertions, and initial queries:
    - To create a cascade reaction constraint on the "newspaperHeaders" table;
    - To create a reaction constraint on the "privateAds" table so that if the ad code is modified/deleted, the "adId" in the "privateAds" table is set to NULL;
12. Ensure that the following conditions are present in the database (verification is observational - the student observes the database - there are no SQL instructions to be performed), otherwise take appropriate action:
    - At least three newspaper headers;
    - As many editorial committees as there are newspaper headers inserted;
    - A number of people greater than or equal to three who make up the editorial committees, taking into account that some editors may be part of multiple committees;
    - Categories of articles, each with a different number of subcategories (e.g., rentals and sales are subcategories of houses);
    - At least 10 private ads and 10 company ads;
13. Perform the following queries:
    - To display the name of all newspaper headers present in the database;
    - To display the list of editors present in the database, showing all available information;
    - To display the list of editors present in the database, showing surname and name;
    - To display the list of editors present in the database, showing surname, name, and email;
    - To display the list of editors present in the database whose email starts with the letter "a";
    - To display the editors who have entered a correct email (those in which the email field contains an "@" symbol);
    - To display the editors who have entered an incorrect email (those in which the email field does NOT contain an "@" symbol);
    - To display the name of the committee for all editorial offices present in the database, if the website address is also available;
    - To display the text and code of ads in the "house" category, if this category is not present, choose another one;
    - To display the code and text of all ads that contain the word "house";
    - To display the code and text of all ads that contain the word "house" and the substring "sell";
    - To display the code and text of all ads that contain the substring "modic";
    - To display the list of private individuals present in the database;
    - To display the list of private individuals from the city with ZIP codes: 70125 or 70126;
    - To display the list of companies whose phone numbers contain the digits: 556.

Part 3:

Continuing to edit the sql file provided in the previous exercise, verify with the appropriate queries (displaying the results on the screen) that the following information is present in the database, if it is not, modify the structure of the database and/or add data using SQL expressions.

- At least three newspaper headers;
- As many editorial committees as there are newspaper headers inserted;
- A number of people greater than or equal to three who make up the editorial committees, taking into account that some editors may be part of multiple committees;
- Categories of articles, each with a different number of subcategories (e.g., rentals and sales are subcategories of houses);
- At least 10 private ads and 10 company ads;
- Values in the fields: age and house number, in the privati table;
- Values in the fields: house number and year of foundation, in the aziende table.

Perform the following queries:

- Display the name of all companies present in the database;
- Display the name of all companies present in the database with a year of foundation before 1980;
- Display the name of all companies present in the database with a year of foundation after 1998;
- Display the name of all companies present in the database with a year of foundation between 1980 and 1998;
- Display the list of private individuals present in the database, showing all available information, avoiding the use of the asterisk;
- Display the list of private individuals present in the database who live in a house number greater than 20, showing surname, name, and house number;
- Display the list of private individuals present in the database who live in a house number equal to 10 or 15, showing surname, name, and house number;
- Display surname, name, street, house number, and ZIP code of private individuals whose house number is between 15 and 30, display ZIP code as Codice_Avviamento_Postale;
- Display the name and capital of the companies, also display half of the capital with the name: Plafond_max_disponibile;
- Display the ages and names of private individuals who are younger than 30;
- Display the name of the committee for all editorial offices present in the database that have a substring in the name consisting of three letters, with the middle letter not important: "m t";
- Create a table PrivatiGiovani with the same characteristics as the Privati table and without interrelational integrity constraints;
- Insert into the PrivatiGiovani table all the private individuals contained in the Privati table who are younger than 30;
- Rename the surname of the PrivatiGiovani whose surname starts with the letter "P" with the word "Rossi";
- Rename the name of the PrivatiGiovani whose name contains the substring "aur" with the word "Arnold";
- Display surname, name, and age of the private individuals whose name is Arnold, in particular display the name field as "Nick";
- Display surname, name, and age of the private individuals whose surname is "Rossi", in particular display a single field cognomenome as "Pilota";
- Display the list of companies whose phone numbers start with 080.

Part 4:

Continuing to edit the sql file used in the previous exercise, perform the following queries.

- Display the name and house number of all companies present in the database that have or could have a house number greater than 15;
- Display the name and year of foundation of all companies present in the database that have or could have a year of foundation before 1980;
- Display the name of all companies present in the database that have or could have a year of foundation between 1980 and 1998;
- Display the code, text, and category of the ads present in the database;
- Display the list of ad codes and company codes (insaz table);
- Display for each ad code present in insaz the company name, contact person, and phone number using the Cartesian product;
- Display, using the Cartesian product, the code, text, and category of the ads with their respective company name, contact person, and phone number, using the aziende, insaz, and inserzioni tables;
- Display the previous query by renaming the tables as follows: aziende to elenco_aziende, insaz to IA, inserzioni to pubblicazioni;
- Display the previous query by renaming the following attributes: code to codice_articolo, text to descrizione;
- Of the previous query, display only the companies that have a capital greater than 18000000;
- Display the list of names of private individuals present in the database;
- Display the list of different names of private individuals present in the database;
- Repeat queries from number 45 to number 48 using NATURAL JOIN;
- Repeat queries from number 45 to number 48 using Theta JOIN;
- Display the query at point 45 ordered by phone numbers;
- Display the query at point 45 ordered by descending phone numbers;
- Display the list of companies, indicating the ZIP code of the city where they are located;
- Display the list of companies, and for each one indicate the name of the city where they are located, the ZIP code, and the province;
- Display the list of private individuals, and for each one indicate the ZIP code of the city of residence;
- Display the list of private individuals, and for each one indicate the ZIP code, name, and province of the city where they reside;
- Display the list of cities, and for each city, the name of the company that is located in the city, and the name and surname of the private individuals who reside in the city (be careful not to display the same information twice);
- Display the private individuals whose surname starts with the letter P or the letter A, indicating the codes of the ads they have placed;

Part 5:

Continuing to edit the sql file used in the previous exercise, perform the following queries.

- Repeat the previous point by also displaying the category of the ad;
- Repeat the previous point by also displaying the text of the ads;
- Display the names of the private individuals and the names of the newspaper headers in which the private individuals have placed ads;
- Display the names of the private individuals, the names of the newspaper headers in which the private individuals have placed ads, and the names of the editorial committees that manage the displayed newspaper headers;
- Display the previous query by also displaying the names of all editors present in the newspaper headers;
- Perform the query at the previous point by displaying only the private individuals whose surname starts with the letter p or the letter a.
- Display the text of the ads in the main categories (those that do not have a parent category);
- Display the number of ads in the main categories;
- Modify the script related to insAz to add the attribute "costo" in the insAz table;
- Insert the cost of the ads into the insAz table, ranging from 30 to 50 euros;
- Display the total amount spent by the company with code 'COM000' to publish the ads;
- Display all information about the published ads;
- Display the total number of published ads;
- Display the ads that contain the string 'affa' in the text;
- Display the number of ads that contain the string 'affa' in the text;
- Display the code and cost of the total ads (use UNION operator between insAz and insPriv tables);
- Display the number of total ads (use UNION operator between insAz and insPriv tables);
- Display the number of private ads and the number of company ads;
- Show how many ads there are for each category.
- Display the ads that belong to more than one category.

Part 6:

- Display the number of ads present in each category;
- Display the number of published ads for each newspaper header (insTest connects the ads to the newspaper headers);
- Display how many newspaper headers each ad is present in;
- Display the ads from companies that cost less than 35;
- Display the number of ads from companies that cost less than 35;
- How many private individuals are there in each city, excluding Putignano?
- Display the private individuals from Bari ordered by name;
- Display the average age of private individuals grouped by name;
- Display the name, surname, and age of the private individual with the highest age;
- Sort the ads from companies (insAz) by ascending cost and, in case of equal cost, by descending codes;
- Sort the ads from companies (insAz) by descending cost and, in case of equal cost, by descending codes;
- Display for each ad its description;
- Display for each ad the code of the company that published it;
- Display for each ad the code of the company that published it and the name of the contact person;
- Display for each ad the code of the company that published it, the name and phone number of the contact person, and the city of the company;
- Display for each ad the code of the private individual who published it;
- Display for each ad the code and name of the private individual who published it;
- Display the number of ads from companies that have published in the newspaper header with the highest number of ads, also showing the name of the newspaper header.
