create table address(
  address varchar(100),
  primary key(address)
);

create table customer(
  customer_id serial,
  name varchar(50),
  address varchar(100) references address(address),
  email varchar(50),
  init_regi timestamp,
  is_borrowing boolean,
  ref_by integer references customer(customer_id),
  problem_user boolean,
  primary key(customer_id)
);

create table note_tags(
  note_tags varchar(20),
  primary key (note_tags)
);

create table manufacturer(
  manu_name varchar(50),
  primary key(manu_name)
);

create table model_number(
  model_num integer,
  manu_name varchar(50) references manufacturer(manu_name),
  range numeric,
  weight numeric,
  top_speed numeric,
  primary key(model_num)
);

create table scooter(
  scooter_id serial,
  model_num integer references model_number(model_num),
  condition varchar(20) check (condition in ('new', 'slightly used', 'used')),
  primary key(scooter_id)
);

create table transaction(
  transaction_id serial,
  customer_id integer references customer(customer_id),
  scooter_id integer references scooter(scooter_id),
  start_time timestamp,
  return_by timestamp,
  end_time timestamp,
  prepay_amt money,
  late boolean,
  damaged boolean,
  penalty money,
  total_cost money,
  notes text,
  note_tags varchar(20) references note_tags(note_tags),
  primary key(transaction_id)
);






