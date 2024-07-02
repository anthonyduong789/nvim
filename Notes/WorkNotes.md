## TODO

> currently making a siteContainsAllNecessaryfields
> when it does will be able to say isItemIsactive

### packagelock.json policy

> dont increment

<!--delete packalock.json options -->
<!--and npm install it again-->
<!--adding a enum for a that will have a set options-->
<!-- pksk -->

> pk + sk
> u id ?
> in general pk shouldn't be a enum
> filterexpress

## currently working on

> making a dao for the dynamo db
> in this implementations I'm using extending the versioned object with my dao for operations
> the table will essentially have a list of the objects

> Operations
> items: Operations[]

### how to implement the the use of the query my certain fields

in the member example we are making a hash for each field and then we simply query by that field
using the hash

## Query by hash return value

> returns a list of the DynamoItem<T>

```typescript
//return
/*
items: DynamoItem < T > [];
lastKey?: AWS.DynamoDB.DocumentClient.Key
***/

export interface DynamoItem<T extends BaseObject> {
  PK: string;
  SK: string;

  GSI1PK?: string;
  GSI1SK?: string;

  GSI2PK?: string;
  GSI2SK?: string;

  GSI3PK?: string;
  GSI3SK?: string;

  // Used for optimistic locking
  DynamoVersion: number;

  // all attributes of T
  item: T;
}
```

```

```

createing DMRDynamoVersion
{
CreationNote?: string;
Version: number;
SUStatus: Status;
Author: string;
TimeCreated: number;
DMRRevision: number;
DMRStatus: string;
}
DMR is the major version
Su it he minor version

## Building out the access patterns for the Operations data table

```typescript
export interface DMRObject extends VersionedObject {
  DMRRevision: number;
  DMRStatus: string;
}

export interface VersionedObject extends BaseObject {
  CreationNote?: string;
  Version: number;
  SUStatus: Status;
  Author: string;
  TimeCreated: number;
}
DMR is the major version
Version is the minor version

8.1.1.3.3
DMR.Version
// ex
Differenet DMR Version
1.0
2.0

Different Versions
1.0
1.1

```

## spec notes then interpret them into the access patterns

- Active version of an operation: Obtain record with the most recent DMR version and with status “Active”
  and a given “Site”, “Department” and “Operation Name”

1. SUStatus == "ACTIVE" with the highest DMRRevision for each DMR + Version
   filtered by Site Department, and Operation Name to check if it exists
   - method: list_Most_Recent_ActiveVersions_By_Site_Department_OperationName

- Obtain record(s) with the most recent version and with status “Active”

2. Highest highest version with status active ->
   SUSatus == "ACTIVE" with the highest DMRRevision for each DMR
   - method: listMostRecentActiveVersion

- Obtain record(s) with the most recent version of a given “Operation Name”

3. Highest active version of a DMR + Version with filtered by a Operation Name
   i.e 1.0, 1.1, 1.2, 2.0, 2.1, 2.2
   2.2 SUStatus == "ACTIVE"

   - method: listMostRecentActiveVersionByOperationName

4. DELTED access pattern as we deleted ProductName

- Operation(s) belonging to a manufacturing change order: Obtain record(s) with the most recent version
  for each DMR version and a given “Manufacturing Change Order”

5. For each DMRRevision, find the highest Version filtered by a Manufacturing change order.
   i.e for each dmr revesion find the highest Version then filter again by Manufacturing change order
   example: 1.0, 1.1, 1.2, 2.0, 2.1, 2.2
   -> 1.2, 2.2

- Operations using a particular material SKU: Obtain record(s) with the most recent DMR version and with
  status “Active” a given “Material SKU”

6. SUStatus == "ACTIVE" with the highest DMRRevision then filtered by "Material SKU"

- Operations using particular equipment: Obtain record(s) with the most recent DMR version and with
  status “Active” a given “Equipment and Tool ID”

7. Highest DMRRevision with the highest with Active with "Equipment AND Tool ID"
