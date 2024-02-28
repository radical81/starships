#  Wrap Response in Loadable Enums
#### 28 February 2024
---

### Status
Initial implementation.

### Context
The initial default way of implementing the view states when waiting for data being fetched.

### Decision
The use of loadable will allow the view to react differently depending on the phase of a data fetch via an API. For instance, waiting for data will show a different view from a successful response, and a failing response for an API call.

### Consequences
This will make the state of the API call visible to the user as oftentimes it takes some time for data to load.

    


