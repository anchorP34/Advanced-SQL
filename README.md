# Advanced-SQL
SQL that will make life easier

# Dynamic Dim Joins.sql
This script is dynamic T-SQL (MS SQL Server) that is useful for relational databases and tables. Using a Fact and Dim model, this script will look at the information schema for that fact table, grab all of the dimensional foreign keys, and print a SQL statement that joins all of the tables together. This can save a lot of time for fact tables that have lots of dimensional foreign keys. 

# Interval Case Statement Function.sql
This script will create a T-SQL funciton to help create a case statement over an interval. For example, if you want to break up values from 0 to 100 into 10 different equal intervals, you can use this function to create a CASE statement for those intervals. Additional documentation is in the header of the function.
