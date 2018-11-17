select name from customer where problem_user = TRUE;

select scooter_id from scooter where scooter_id not in (select scooter_id from transaction);

select scooter.model_num, model_number.manu_name, customer.name, transaction.return_by
  from scooter
  inner join model_number on model_number.model_num = scooter.model_num
  inner join transaction on transaction.scooter_id = scooter.scooter_id
  inner join customer on transaction.customer_id = customer.customer_id
  order by return_by; --ascending timestamp returns older values first

select scooter.model_num, model_number.manu_name, customer.name
  from scooter
  inner join model_number on model_number.model_num = scooter.model_num
  inner join transaction on transaction.scooter_id = scooter.scooter_id
  inner join customer on transaction.customer_id = customer.customer_id
  where transaction.late = TRUE;


