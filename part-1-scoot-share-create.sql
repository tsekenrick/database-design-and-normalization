create table customer(
  customer_id serial,
  address varchar(100) references address(address),
  email varchar(50),
  init_regi timestamp,
  is_borrowing boolean,
  ref_by integer references customer(customer_id),
  problem_user boolean,
  primary key(customer_id)
);

create table address(
  address varchar(100),
  primary key(address)
);

create table transaction(
  transaction_id serial,
  customer_id integer references customer(customer_id),
  return_by timestamp,
  end_time timestamp,
  prepay_amt money,
  late boolean,
  damaged boolean,
  penalty money,
  total_cost money,
  notes text,
  scooter_id references scooter(scooter_id),
  primary key(transaction_id)
);

create table scooter(
  scooter_id serial,
  model_num integer references model_number(model_num),
  range numeric,
  weight numeric,
  top_speed numeric,
  condition varchar(20) check (condition in ('new', 'slightly used', 'used')),
  primary key(scooter_id)
);

create table model_number(
  model_num integer,
  manu_name varchar(50) references manufacturer(manu_name),
  primary key(model_num)
);

create table manufacturer(
  manu_name varchar(50),
  primary key(manu_name)
);
