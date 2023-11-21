-- Exercises
-- Subqueries

/*
Q1. Write a SELECT statement that returns the same result set as this SELECT 
statement, but don't use a JOIN. Instead, use a subquery in a WHERE clause that 
uses the IN keyword.
SELECT DISTINCT vendor_name
FROM vendors JOIN invoices 
    ON vendors.vendor_id = invoices.vendor_id
ORDER BY vendor_name;
*/
SELECT distinct vendor_name
FROM vendors
WHERE vendor_id IN 
    (SELECT DISTINCT vendor_id
    FROM invoices)
ORDER BY vendor_name;
/*
Q2. Write a SELECT statement that answers this question: Which invoices have 
a payment total that's greater than the average payment total for all invoices with a payment total greater than 0?

Return the invoice_number and invoice_total columns for each invoice. This should return 20 rows.
Sort the results by the invoice_total column in descending order.
*/
select invoice_number, invoice_total,payment_total
from invoices 
where payment_total > 
	(select avg(payment_total) 
    from invoices
	where payment_total > 0)
order by invoice_total DESC;
/*
Q3. Write a SELECT statement that returns two columns from the Genreal_Ledger_Accounts table:account_number and account_description.

Return one row for each account number that has never been assigned to any line item in the Invoice_Line_Items table. To do that, use a subquery with the NOT EXISTS operator.

Sort the results by the account_number column.
*/
select account_number, account_description
from General_Ledger_Accounts g
where not exists
	(select * 
    from Invoice_Line_Items 
    where account_number = g.account_number)
order by account_number;
/* 
Q4. Write a SELECT statement that returns four columns: vendor_name, invoices_id, invoice_sequence, and line_item_amount.

Return a row for each line item of each invoice that has more than one line item in the Invoice_Line_Items table.
*/
select vendor_name, L.invoice_id, invoice_sequence, line_item_amount
FROM Invoice_Line_Items L JOIN invoices I ON
L.invoice_id = I.invoice_id
JOIN vendors V ON I.vendor_id = V.vendor_id
WHERE L.invoice_id IN
	(SELECT invoice_id
	FROM Invoice_Line_Items
	WHERE invoice_sequence > 1);
/*
Q5. Write a SELECT statement that returns two columns: vendor_id and the largest unpaid invoices for each vendor. To do this, you can group the result set by the vendor_id column. 

Write a second SELECT statement that uses the first SELECT statement in its FROM clause.The main query should return a single value that represents the sum of the largest unpaid invoices for each vendor.
*/
select sum(max_invoice)
from (SELECT vendor_id, MAX(invoice_total) AS max_invoice
      FROM invoices
      WHERE invoice_total - credit_total - payment_total > 0
      GROUP BY vendor_id) as m ;
/*
Q6. Write a SELECT statement that rerturns the name, city, and state of each vendor that's located in a unique city and state. In other words, don't include vendors that have a city and state in common with another vendor.

Sort the results by the vendor_state and vendor_city columns.
*/
Select vendor_name, vendor_city, vendor_state
FROM vendors
WHERE vendor_city
     NOT IN 
   (SELECT vendor_city
    FROM   vendors
    GROUP BY vendor_city, vendor_state
    HAVING COUNT(*) > 1 )
ORDER BY vendor_state, vendor_city;

/*
Q7. Use a correlated subquery to return one row per vendor, representing the vendor's oldest invoices(the one with the earliest date). 
Each row should include these four columns: vendor_name, invoice_number, invoice_date, and invoice_total.
Sort the result by the vendor_name column.
*/
SELECT vendor_name, invoice_number AS oldest_invoice,
invoice_date, invoice_total
FROM invoices i_main JOIN vendors v
ON i_main.vendor_id = v.vendor_id
WHERE invoice_date =
(SELECT MIN(invoice_date)
FROM invoices i_sub
WHERE i_sub.vendor_id = i_main.vendor_id)
ORDER BY vendor_name;
/* 
Q8. Rewrite exercise 7 so it gets the same result but uses an inline view instread of a correlated subquery.
*/
SELECT vendor_name, invoice_number AS oldest_invoice,
oi.oldest_invoice_date, invoice_total
FROM invoices i JOIN
(SELECT vendor_id, MIN(invoice_date) AS oldest_invoice_date
FROM invoices
GROUP BY vendor_id) oi
ON (i.vendor_id = oi.vendor_id AND
i.invoice_date = oi.oldest_invoice_date)
JOIN vendors v
ON i.vendor_id = v.vendor_id
ORDER BY vendor_name;