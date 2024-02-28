#  Hide API Implementation
#### 28 February 2024
---

### Status
Initial implementation.

### Context
The initial default way of implementing API calls for the entire app.

### Decision
The API interaction with the app is hidden via a protocol. This will allow changing the API source later on without too much refactoring. 

### Consequences
This will be useful mocking and testing data that may not be pointing to a real API service. Implementation is hidden and the protocol acts as a contract between the app and the news service API.
