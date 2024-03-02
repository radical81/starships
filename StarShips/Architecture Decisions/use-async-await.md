#  Use Async-Await
#### 3 March 2024
---

### Status
Initial implementation.

### Context
The initial default way of implementing asynchronous calls for API calls.

### Decision
The choice for using async-await from the beginning was to avoid the problems that come with writing code with the other two asynchronous implementations:
1. Dispatch Queues
2. Closures

Async-await simplifies the way asynchronous code is written so they can be written line by line similar to synchronous code. Assigning values to a variable for example, where a value results from an asynchronous data fetch, can be written just as a simple assignment statement:

      dataForLoading = await Shared.DataFetcher.fetchCollection()

### Consequences
This eliminates the problems with scoping result variables within the closure, and managing the threads in a dispatch queue.

    


