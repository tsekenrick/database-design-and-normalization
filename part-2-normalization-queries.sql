--combines a pokemon's stats with its generation, pokedex number and
--legendary status matching on the pokemon name - basically presents
--each pokemon and its stats
select *
  from pokemon
  inner join stats on pokemon.name = stats.name;

--admittedly not a particularly useful query, but this matches
--for generation 3 pokemon by comparing the fields in the
--generation and pokemon tables, and then prints any non-gen-3
--pokemon in the pokemon table anyways. given the nature of this
--data set, it was hard to do an outer join that didn't have
--lots of redundant information.
select *
  from pokemon
  left outer join generation on generation.generation = 3;

--essentially a query that checks for "power creep" - whether or not
--the average power of pokemon has increased over the 6 generations.
--does so by grouping by generation and using an avg aggregate function
--on a stats-pokemon joined table. as it turns out, the answer is here
--hasn't been significant power creep across the generations.
select generation, avg(hp + attack + defense)::integer
  from pokemon
  inner join stats on pokemon.name = stats.name
  group by pokemon.generation;

