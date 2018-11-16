create schema staging;

create table staging.pokemon(
  pokedex_num integer,
  pokename varchar(100),
  type_one varchar(25),
  type_two varchar(25),
  hp integer,
  attack integer,
  defense integer,
  sp_atk integer,
  sp_def integer,
  speed integer,
  generation integer,
  legendary varchar(10)
);

copy staging.pokemon (pokedex_num, pokename, type_one, type_two, hp, attack, defense,
sp_atk, sp_def, speed, generation, legendary)
from 'D:/Documents/NYU/Data Analysis/tsekenrick-homework05/pokemon_cleaned.csv' delimiter ',' csv header;

-----

create table pokedex_num(
  pokedex_num integer,
  primary key(pokedex_num)
);

create table generation(
  generation integer,
  primary key(generation)
);

create table pokemon(
  name varchar(50),
  legendary boolean,
  generation integer references generation(generation),
  pokedex_num integer references pokedex_num(pokedex_num),
  primary key(name)
);

create table poketype(
  poketype varchar(25),
  primary key(poketype)
);

create table pokemon_poketype(
  name varchar(50) references pokemon(name),
  poketype varchar(25) references poketype(poketype)
);

create table stats(
  name varchar(50) references pokemon(name),
  hp integer,
  attack integer,
  defense integer,
  sp_atk integer,
  sp_def integer,
  speed integer,
  primary key(name)
);



