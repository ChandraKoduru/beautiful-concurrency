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


