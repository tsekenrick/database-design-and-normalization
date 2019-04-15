# Database Design and Normalization
This two-part assignment was designed to further our familiarization with designing a SQL database, importing data into our model
and running queries. The first part of the assignment asks us to create a database that represents the business model of a
hypothetical scooter rental company. We were given some liberties as to how much we should normalize our data, considering the
purpose of the model. We then drew up an ER diagram, created the database and wrote some mock queries.

The second part of the assignment asks us to find an existing, un-normalized dataset, and design a SQL database that normalizes and
represents a portion of that data. We then import the data into our model and run queries on it.

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
I assumed that the functionality for retrieving info of returning customers, was largely
handled by the front-end application. While the database certainly includes enough information
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

For the freeform notes associated with each transaction, I assumed that each note would be
unique, and not some generic pre-generated note - because of this I kept the note as an
attribute within the transaction table. However, for the tags associated with the notes,
I assumed these were selected from a pool of tags (i.e. non-unique), so they were kept
in a separate table with a foreign key referencing the tag in the transaction table, 
to demonstrate the one-to-many relationship.

For the referral system, I assumed that each person could be referred by only one person,
therefore that it is a one (customer doing the referring) to many (all people that the
customer referred) relationship, which can be illustrated by having a foreign key that
references the customer table itself.

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
