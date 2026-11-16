SELECT * FROM users WHERE username = 'John' AND password = 'Un@detectable444';
This query will be executed in the database. As per this query, the database will check for a user named John and the password of Un@detectable444. If it finds such a user, it will return the user’s details to the application. Note that the above query will be successful only if the given user and pass both have a match together in the database as they are separated by the boolean “AND”.


SELECT * FROM users WHERE username = 'John' AND password = 'abc' OR 1=1;-- -';
This statement looks similar to the previous SQL query but now adds another condition with the operator OR. This query will see if there is a user, John. Then, it will check if John has the password abc (which he could not have because the attacker entered a random password). Ideally, the query should fail here because it expects both username and password to be correct, as there is an AND operator between them. But, this query has another condition, OR, between the password and a statement 1=1. Any one of them being true will make the whole SQL query successful. The password failed, so the query will check the next condition, which checks if 1=1. As we know, 1=1 is always true, so it will ignore the random password entered before this and consider this statement as true, which will successfully execute this query. The -- - at the end of the query would comment anything after 1=1, which means the query would be successfully executed, and the attacker would get logged in to John’s user account.

One of the important things to note here is the use of a single quote ' after abc. Without this single quote,' the whole string 'abc OR 1=1;-- -' would be considered the password, which is not intended. However, if we add a single quote ' after abc, the password would look like 'abc' OR 1=1;---', which encloses the original string abc in the query and allows us to introduce a logical condition OR 1=1, which is always true.

SQLMap is an automated tool for detecting and exploiting SQL injection vulnerabilities in web applications. It simplifies the process of identifying these vulnerabilities. This tool is built into some Linux distributions, but you can easily install it if it's not.

What would be the full command of SQLMap for extracting all tables from the "members" database? (Vulnerable URL: http://sqlmaptesting.thm/search/cat=1)
sqlmap -u 'http://sqlmaptesting.thm/search/cat=1' -D members --tables

