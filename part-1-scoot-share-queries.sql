select name from customer where problem_user = TRUE;

select scooter_id from scooter where scooter_id not in (select scooter_id from transaction);

select scooter.model_num, model_number.manu_name, customer.name, transaction.return_by
  from scooter
  inner join model_number on model_number.model_num = scooter.model_num
  inner join transaction on transaction.scooter_id = scooter.scooter_id
  inner join customer on transaction.customer_id = customer.customer_id
  order by return_by asc; --ascending timestamp returns older values first

select scooter.model_num, model_number.manu_name, customer.name
  from scooter
  inner join model_number on model_number.model_num = scooter.model_num
  inner join transaction on transaction.scooter_id = scooter.scooter_id
  inner join customer on transaction.customer_id = customer.customer_id
  where transaction.late = TRUE;

select ref_by, count(ref_by) from customer
  group by ref_by order by count(ref_by) desc limit 5;

--replace {search_query_here} with the customer id of the customer you want information for
select transaction_id, start_time from transaction where transaction.customer_id = {search_query_here}
  order by start_time asc; --returns chronologically - first entry is oldest

--included the "notes" field for completeness, in case it has information pertaining to damage/lateness.
--query does not need to include a search matching for customer_id since transaction_id is already unique.
--as with above, replace {search_query_here} with the transaction_id that you want information for.
select damaged, late, penalty, notes from transaction where transaction_id = {search_query_here};

select * from manufacturer;