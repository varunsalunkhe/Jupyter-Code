/* Write SQL statement based on below query given by business for data extraction from MySQL DB. */

/* Q1. Retrieve three columns from each row, sorted in descending sequence by invoice total. */



/* Q2. Retrieve two columns and a calculated value for a specific invoice. */



/* Q3. Retrieve all invoices between given dates of “2018-06-01” to “2018-06-30” and order it accordingly. */



/* Q4. Retrieve all the balance due to generated invoices till date. */



/* Q5. Write a SELECT statement that returns below given columns and data from the invoice table: 

Due Date                  The invoice_due_date column  

Invoice Total            The invoice_total column 

10%                            10% of the value of invoice_total  

Plus 10%                    The value of invoice_total plus 10% 

Return only the rows with an invoice total that’s greater than or equal to 500 
and less than or equal to 1000 and Sort the result set in descending sequence by invoice_due_date. */

/* Q6. Write a statement that returns below given columns from invoices table: 

Invoice number                The invoice_number column  

Invoice Total                     The invoice_total column  

Payment Credit Total      Sum of the payment_total and credit_total columns 

Balance Due                      The invoice_total column minus the payment_total and credit_total columns  

Return only invoices that have a balance due that’s greater than $50. 
Sort the result set by balance due in descending sequence. 
Limit the result set contains only the rows with the 5 largest balances.  */




/* Q7. Write a statement without a FROM clause that creates a row with given below columns: 

Starting Principal                Starting principal of $50, 000 

Interest                                 6.5% of the principal  

Principal Plus interest         The principal plus the interest  

Add the expression used for the first two columns to calculate the third column. */




/* Q8. Write a statement that returns all columns from Vendors table with all columns from the Invoices table.  */




 /* Q9. Write a statement to return data for the column’s vendor_name, invoice_number, invoice_date and balance_due. 
Use aliases for the tables: v for Vendors and i for Invoices. 
Return one row for each invoice with a non-zero balance and sort the result set by vendor_name in ascending order. */




/* Q10. Write a statement that returns data for the column’s vendor_id, vendor_name and contact_name. 
Return one row for each vendor whose contact has the same last name as another vendor’s contact and 
Sort the result set by vendor_contact_last_name. */




/* Q11. Write a statement to generate a result set consisting of two columns from the Vendors table: vendor_name and vendor_state. 
If the vendor is in California, the vendor_state value should be “CA” otherwise, the vendor_state value should be “Outside CA”. 
Sort the final result set by vendor_name. */




/* Q12. Write a statement that returns one row for each vendor in the Invoices table that contains given 
columns, vendor_id, sum of the invoice_total. Sort the result set in descending sequence by the payment total sum of each vendor. */




/* Q13. Write a statement that returns one row for each general ledger account number that contains 
columns account_description, count of the items in the invoice_items table that have the same 
account_number, sum of the line_item_amount columns in the invoice_line_items table that have the same account_number. 
Return only those rows where the count of line items is greater than 1. Group the result set by the 
account_description column and sort the result set in descending sequence by the sum of the line-item amount.  */





/* Q14. Write a statement that answers this given question: What are the last payment date and total amount due 
for each vendor with each terms id? It needs to return terms_id, vendor_id and last payment date for each 
combination of terms id and vendor id in the Invoices table and the sum of the balance due 
(invoice_total – payment_total – credit_total) for each combination of terms id and vendor id in the invoice table.  

Use the WITH ROLLUP operator to include rows that give a summary for each terms id as well as a row that gives the grand total.  

Use the IF and GROUPING functions to replace the null values in the terms_id and vendor_id columns with literal values 
if they’re for summary rows. */





/* Q15. Write a statement to answers these questions: Which invoice have a payment total that’s greater than 
the average payment total for all invoices with a payment total greater than 0? 

Return the invoice_number and invoice_total columns for each invoice and Sort the result by 
the invoice_total column in descending order. */





/* Q16. Write a statement that returns two columns from  the General_Ledger_Accounts table: account_number and account_description. 

Return one row for each account number that has never been assigned to any line item in the invoice_line_items table. 
Use NOT EXISTS operator and Sort the results by the account_number column. */





/* Q17. Write a statement that returns four columns: vendor_name, invoice_id, invoice_sequence, and line_item_amount. 
Returns a row for each line items of each invoice that has more than one-line items in the Invocie_Line_Items table. 
Sort the results by the vendor_name, invoice_id, and invoice_sequence columns. */




/* Q18. Write a statement that retuns one row form each vendor that contains three columns:
The vendor_name column from the Vendors table
The count of the Invoices table for each vendors
The sum of the invoice_total columns in the Invoices table for each vendor
Sort the result set so the vendor with the most invoices appears first */




/* Q19. Write a statement that answers this question: Which vendors are being paid from more than one account? Return these columns:
The vedor name from the Vendors table
The count of the distict genral ledger accounts that apply to that vendor's invoices*/




/* Q20. Write a statement that returns one row fro each vendor in the Invoices table that contains these columns:
The vendor_id column from the Vendor table
The sum of invoice_total columns in the Invoices table for that vendor */
