--import data from csv into staging table
copy staging.pokemon (pokedex_num, pokename, type_one, type_two, hp, attack, defense,
sp_atk, sp_def, speed, generation, legendary)
from 'D:/Documents/NYU/Data Analysis/tsekenrick-homework05/pokemon_cleaned.csv' delimiter ',' csv header;
select * from staging.pokemon where pokedex_num > 500;

--get all unique generations from staging
insert into generation(generation) (select distinct generation from staging.pokemon);
select * from generation;

--get all unique pokedex numbers from staging
insert into pokedex_num(pokedex_num) (select distinct pokedex_num from staging.pokemon);
select * from pokedex_num;

--populate "main" pokemon table with relevant data from staging
insert into pokemon(name, generation, pokedex_num, legendary) (select pokename, generation, pokedex_num, legendary::boolean from staging.pokemon);
select * from pokemon;

--get all unique pokemon types from staging
insert into poketype(poketype) (select distinct type_one from staging.pokemon);
insert into poketype(poketype) (select distinct type_two from staging.pokemon where type_two not in (select poketype from poketype));
select * from poketype;

--populate pokemon_poketype table
insert into pokemon_poketype(name, poketype)
select pokename, poketype
from
     --get types of pokemon from staging
     (select pokename, type_one, type_two from staging.pokemon) as pokemon_poketype
--match with available poketypes
inner join poketype on (poketype.poketype = type_one or poketype.poketype = type_two);
select * from pokemon_poketype;

--populate stats table
insert into stats(name, hp, attack, defense, sp_atk, sp_def, speed)
    (select pokename, hp, attack, defense, sp_atk, sp_def, speed from staging.pokemon);
select * from stats;