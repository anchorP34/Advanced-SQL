# Advanced-SQL
SQL that will make life easier

# Dynamic Dim Joins.sql
This script is dynamic T-SQL (MS SQL Server) that is useful for relational databases and tables. Using a Fact and Dim model, this script will look at the information schema for that fact table, grab all of the dimensional foreign keys, and print a SQL statement that joins all of the tables together. This can save a lot of time for fact tables that have lots of dimensional foreign keys. 
