# beautiful-concurrency


https://www.schoolofhaskell.com/school/advanced-haskell/beautiful-concurrency/1-introduction

### Parallelism

Parallelism employs multiple processors to make program run faster. Performance is the only goal. 

Ideally semantics of the program is unchanged from the semantics of the sequential program.

It always gives the same, deterministic results and if it works on a uni-processor it'll work on a multi-processor.

Using par is a good example of parallelism in Haskell.

Parallelism is therefore to do with implementation.

### Concurrency

Concurrency describes a situation where non-determinism behaviour, and having many things going on at once, is part of the specification of the program.

In a web server you want a thread to deal with each client; in a telephone switch you have many concurrent phone calls going on at once.

This concurrency must happen even on a uni-processor.

Using forkIO to fork an explicit thread is a signal that program uses concurrency.

### Using unsafePerformIO

* To implement Arbitrary instance of Account
* To implement Show instance of Account


### QuickCheck testing in ghci

```

stack test

stack ghci beautiful-concurrency:test:beautiful-concurrency-test

> import Test.QuickCheck -- for generate, sample
> import BankingSystem --  for Account
>
> generate (arbitrary :: Gen Account)
Account {Name:R?YI?, Balance:26}
it :: Account
>
> sample (arbitrary :: Gen Account)
Account {Name:, Balance:0}
Account {Name:Z, Balance:1}
Account {Name:M$, Balance:2}
Account {Name:n?$?, Balance:0}
Account {Name:H, Balance:4}
Account {Name:	IVP?`?]x, Balance:4}
Account {Name:y/b>KL@?gT, Balance:9}
Account {Name:ns, Balance:0}
Account {Name:ILYYL[3??, Balance:2}
Account {Name:{ZUP::2,;?NRc??=, Balance:2}
Account {Name:&, Balance:0}
>
```
