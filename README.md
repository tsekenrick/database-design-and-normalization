# Homework 05

## Scoot-Share

![er diagram for scoot share](er-diagram.png)

### Design Decisions

The database I created is not in 3NF - in particular, the transaction and scooter
tables have fields with transitive dependencies. For the transaction table, such 
fields include `late`, `total_cost`, and potentially `penalty`. These fields are
implied by other fields in the table (for example `late` can be calculated using
`end_time` and `return_by`). However, maintaining these fields allowed for easier
access to information that was quite important for the business logic that the 
database represented, so I felt their inclusion was warranted. In order to prevent
update anomalies with these fields, certain constraints and triggers would need
to be applied within the design.

For the purposes of simplicity, the `address` table has only a single field. It is
obviously possible to extend this to fields like `zip`, `country`, `state`, etc,
but this would require additional tables to represent the one-to-many relationship,
and doesn't meaningfully add to the functionality of the database.

Similarly, the freeform notes section of the transaction table could have been
extended out into its own table and included more robust fields, but this seemed
like an uncessary complication.


### Assumptions
The most notable assumption made is regarding the functionality for retrieving info
of returning customers. While the database certainly includes enough information
to locate a returning customer given certain pieces of information (e.g. some
combination of name, email, address, or even the customer ID), I assume that 
implementing this functionality would be up to the front-end app, not the database.

Similarly, I also assumed that the business logic of restricting a user to 
borrowing one scooter at a time is done with the front-end app, though the
`is_borrowing` field can be used to help create that functionality.

There are also some ambiguities within the transaction table - namely the `start_time`,
`return_by`, `end_time` and `prepay_amt` fields may or may not have transitive dependencies
depending on the exact business logic of Scoot Share. For example, if prepaying immediately
fixes your borrowing time, then `end_time` becomes transitively dependent. However, if
you can prepay a partial amount and then pay the remainder on return, there is no such
issue. Generally, the way that `return_by` and `end_time` are calculated is sort of at
the whim of the particulars of the business model, so some assumptions had to be made there.

I assumed that all scooters of the same model number would have the same 
properties, i.e. same range, weight and top speed.

I assumed that the freeform notes that can be included with each transaction would
be unique.

As stated in the assignment, I also assume that storage of payment information
does not need to be included in the database.

### Scripts

* [part-1-scoot-share-create.sql](part-1-scoot-share-create.sql)
* [part-1-scoot-share-queries.sql](part-1-scoot-share-queries.sql)

## Normalization
For the dataset, the only cleaning I did was to remove the "total" column,
since it was a transitive dependency, and since the information it provided
wasn't particularly useful, it wasn't worth the effort to try normalizing it.

* [Pokemon Dataset Original](Pokemon.csv)
* [Pokemon Dataset Cleaned](pokemon_cleaned.csv)
* [part-2-normalization-create.sql](part-2-normalization-create.sql)
* [part-2-normalization-import.sql](part-2-normalization-import.sql)
* [part-2-normalization-queries.sql](part-2-normalization-queries.sql)
