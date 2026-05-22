# Programming Language Design Questionnaire

---

## 1. Purpose & Philosophy

- What is the primary use case? *(systems, scripting, data, web, embedded, general-purpose, other)* General purpose, I suppose.
- What is the single most important design goal? *(performance, safety, simplicity, expressiveness, other)* expressiveness and siplicity
- Is it meant to replace or complement an existing language? No
- Should a beginner be able to pick it up quickly? Not really
- Should it be opinionated, or give the programmer maximum freedom? freedom I think but not totally sure
- Is correctness enforced by the compiler, or trusted to the programmer? Yes, enforced
- Is it research-oriented or production-oriented? Research and fun

---

## 2. Typing System

- Statically or dynamically typed? Statically
- Strongly or weakly typed? weak? or strong but flexible
- Is type inference supported? Yes
- Are types explicit, implicit, or optional? It depends, can be explicit
- Are there algebraic data types (sum/product types)? No
- Are there dependent types? I dont know what this means
- Are there refinement types? I dont know what this means
- Are there generics / parametric polymorphism? Generics but not polimorfism,
  I think I prefer ir li  this
- Are there union types? *(e.g. `int | string`)* Yes, tagged
- Are there intersection types? Yes, is this not unions?
- Are there nullable types, or is null/nil forbidden? No
- Is there a `void` or `unit` type? Only if its convinient
- Are function types first-class? Yes (functions as values)
- Can types be created at compile time? *(type-level programming)* yes 
- Is structural typing supported? *(duck typing at the type level)* I
  dont know what this is but maybe
- Is nominal typing supported?
- Can the programmer define type aliases? Isnt this a type definition?
- Are there opaque / newtype wrappers? Not sure

---

## 3. Memory Management

- Manually managed, garbage collected, or reference counted? Managed by
  the compiler, scopes, lifetimes
- Is there a borrow checker or ownership model? See previous
- Can the programmer control memory layout? *(stack vs heap)* Maybe not, or
  more limited than in C
- Are there smart pointers? No
- Is stack allocation the default? Yes
- Are there arenas or region-based memory? Maybe as a library
- Is it possible to write allocator-free code? *(e.g. for embedded)* No
- Can the programmer write a custom allocator? Not sure
- Is there a concept of "unsafe" mode for raw memory access? No

---

## 4. Execution Model

- Compiled, interpreted, or transpiled? Compiled (transpiled llvm)
- Is there a JIT compiler? No
- What is the compilation target? *(native binary, bytecode, WASM, JS, other)* llvm
- Is there an REPL? No, but maybe in the future I support
  interpretation + compilation
- Is there an intermediate representation exposed to the user? llvm
- Can programs be run incrementally / hot-reloaded? Maybe I implement
  something funny for compilation
- Is ahead-of-time (AOT) compilation supported? I dont know whay this means.

---

## 5. Paradigms

- Is it object-oriented? Not 100%, but have objects
- Is it functional? everything is a expression
- Is it procedural / imperative?
- Is it logic/constraint-based?
- Is it multi-paradigm? Its what it is
- Is immutability the default? no
- Are side effects tracked by the type system? *(effect system)*
- Is lazy evaluation supported? No?
- Is eager evaluation the default? Yes?

---

## 6. Object-Oriented Features

- Are there classes? No like java ones
- Are there structs? Yes
- Is inheritance supported? Maybe composition
- Is multiple inheritance supported? By compositon
- Are there interfaces or traits? By compilsition. I like odin using
- Are there mixins? Too complex to understand
- Is encapsulation enforced? Yes?
- Are there access modifiers? *(public, private, protected)* All private, +
  pub kword
- Is `this` / `self` explicit or implicit? Explicit maybe
- Are there abstract classes? No
- Is there method overriding? No?
- Are there virtual methods? No
- Are there sealed/final classes? No

---

## 7. Functional Features

- Are functions first-class values? Yes
- Are there anonymous functions / lambdas? Yes, all
- Are there closures? All? maybe not
- Is currying supported? No
- Is partial application supported? No
- Is there pattern matching? No, use match kword
- Are there higher-order functions built in? *(map, filter, reduce)*, No
  std lib
- Is tail-call optimization guaranteed? By llvm
- Are there monads or similar abstractions? 
- Is function composition idiomatic? Yes?
- Are there pure function annotations? No

---

## 8. Operators & Expressions

- Is operator overloading supported? No
- Can new operators be defined? No
- Is there a ternary operator? Maybe yes
- Are assignments expressions or statements? Expressions
- Is there operator precedence, or are expressions fully parenthesized? Operator precedence
- Are there pipeline operators? *(e.g. `|>` )* Yes, `->`
- Are there spread / splat operators? Yes
- Are there null-coalescing / optional-chaining operators? There is not null
- Are there bitwise operators? Maybe not

---

## 9. Control Flow

- Are there `if / else` statements? Yes
- Are there `switch / match` statements? Match for types and values
- Is pattern matching exhaustive? *(compiler warns on missing cases)* Yes
- Are there `for` loops?
- Are there `while` loops?
- Are there `do-while` loops?
- Are there `foreach` / range-based loops?
- Is `break` / `continue` supported?
- Is `goto` supported?
- Are there loop labels? *(to break outer loops)* Yes
- Are there generators / coroutines? yes
- Are there iterators as a first-class concept? yes
- Is there structured early return? *(e.g. guard clauses)* Yes

---

## 10. Error Handling

- Are there exceptions?
- Are errors returned as values? *(e.g. `Result<T, E>`)*
- Are there checked exceptions?
- Is there a `try / catch / finally` mechanism?
- Is there a `defer` / `ensure` mechanism?
- Can errors be ignored without an explicit annotation?
- Is panic / abort supported for unrecoverable errors?
- Are there error hierarchies?
- Is error propagation syntactically easy? *(e.g. `?` operator)*

---

## 11. Concurrency & Parallelism

- Is concurrency built into the language? Might be funny
- Are there threads? I would try to do it by default
- Are there green threads / fibers?
- Is there an async/await model? No
- Are there actors? No, what is this
- Are there channels for communication? Maybe, some sort of shared memory
- Is shared mutable state allowed? Not sure
- Is there a global interpreter lock (GIL) or equivalent? Maybe not
- Is data-race freedom guaranteed by the type system? Trying to do it
- Is there a standard event loop? no?
- Are there atomic types? all by default
- Are there built-in parallel collections? Maybe, not sure how to approach it

---

## 12. Metaprogramming & Macros

- Are there macros? Maybe not
- Are macros hygienic?
- Is there compile-time code execution? *(comptime, constexpr)* Maybe not
- Is there reflection?
- Is there runtime introspection?
- Are there annotations / attributes / decorators?
- Can the compiler be extended by the user? What
- Is there a template system? The generics thing
- Is there code generation tooling built in? It would be fun to provide a
  source string to code function as part of a library
- Are there syntax extensions? No?

---

## 13. Modules & Namespaces

- Are there modules? But the simpest thing ever seen
- Are there packages? Isnt this the same as modules
- Are there namespaces? Not explicit
- Is there a standard module system? Yes
- Can modules be imported selectively? Yes, as part of the siplest module system
- Are circular imports allowed? Not sure, but maybe but prevented
- Is there a concept of visibility between modules? *(public/internal/private)* Yes
- Is there a built-in package manager? Yes, but it isnt a package manager, it
  doesnt manage dependencies

---

## 14. Standard Library

- Is there a rich standard library, or a small core? Rich with the time
- Does the standard library include collections? *(list, map, set, etc.)* 
- Does it include string manipulation utilities?
- Does it include I/O? *(file, stdin/stdout)*
- Does it include networking?
- Does it include concurrency primitives?
- Does it include math utilities?
- Does it include date/time handling?
- Does it include serialization? *(JSON, CSV, etc.)*
- Does it include regular expressions?
- Does it include a test framework?

---

## 15. Strings & Text

- Are strings mutable or immutable?
- Are strings UTF-8, UTF-16, or byte arrays?
- Is string interpolation supported?
- Are there multiline string literals?
- Are there raw string literals? *(no escape processing)*
- Are characters a distinct type from strings?
- Are strings null-terminated or length-prefixed?
- Is Unicode normalization handled automatically?

---

## 16. Collections & Data Structures

- Are arrays fixed-size or dynamic? Tuples are static, array dynamic
- Are there built-in tuples? Yes
- Are there built-in dictionaries / maps? Yes
- Are there built-in sets? Not sure
- Are there built-in queues / stacks? Not sure
- Are collections generic / typed? generic
- Are collections persistent / immutable by default?
- Is there slicing / sub-range syntax? maybe
- Is there a built-in iterator protocol?
- Are there lazy sequences?

---

## 17. Interoperability

- Can it call C libraries natively? Yes
- Does it have a C FFI? Yes
- Can it interoperate with other specific languages? *(which ones?)* Maybe not,
  only sysV abi ffi (.so) and this thing
- Can it be embedded in other languages? If its compiled not
- Can it compile to a library usable from other languages? llvm thing
- Is there WASM support? Would be funny
- Are there bindings to OS APIs? C abi
- Is there interop with a specific runtime? *(JVM, CLR, Node, etc.)*

---

## 18. Tooling

- Is there an official formatter? Future
- Is there an official linter? Future
- Is there an official build system? Yes
- Is there an official test runner? Future
- Is there an official debugger? Future
- Is there an official LSP / IDE support? Future
- Is there an official documentation generator? Yes
- Is there official REPL tooling? Future
- Should tooling be bundled with the compiler or separate? Depends

---

## 19. Syntax & Aesthetics

- Is the syntax closer to C, Python, ML, Lisp, or something else? Like rust +
  haskell + c + ocaml
- Is whitespace/indentation significant? no
- Are semicolons required? not sure
- Are parentheses required around `if` / `while` conditions? no
- Is there significant use of symbols vs keywords? Trying to reduce kwords
- Are there optional parentheses for function calls? maybe
- Are there trailing commas allowed? yes
- Is the language case-sensitive? yes
- What naming convention is idiomatic? *(camelCase, snake_case, PascalCase)* snake
- Are there reserved keywords the programmer cannot use as identifiers? Yes
- Is verbosity preferred over brevity, or vice versa? brevity and simplicity

---

## 20. Safety & Security

- Are there bounds checks on array access? Yes
- Is there buffer overflow protection? There is no buffers
- Is integer overflow caught or wrapped silently? Silent
- Are there safe and unsafe subsets of the language? all safe
- Are uninitialized variables allowed? no?
- Is null pointer access caught at compile time or runtime? There is no null
- Are there sandboxing features?
- Can the language express security invariants in the type system?

---

## 21. Performance

- Is zero-cost abstraction a goal? Maybe
- Are there SIMD / vectorization intrinsics? llvm
- Is inlining controllable by the programmer? no
- Are there compile-time constants / const evaluation? numbers, strings and this kind of constants
- Is there support for value types to avoid heap allocation? No
- Can the programmer control calling conventions? No
- Is link-time optimization supported? maybe, llvm
- Are profiling hooks available in the standard library? no

---

## 22. Target Audience & Ecosystem

- Who is the intended programmer? *(student, professional, researcher, other)* Me
- What domain will have the best library ecosystem?
- Should the community be open-source from day one? Yes
- Is corporate backing expected or avoided? Avoided
- Should the language evolve fast or be stable/conservative? Stable
- Is backward compatibility a hard requirement? Maybe
- Should there be a formal specification? yes
- Should there be a reference implementation? yes

---

*Answer as many as you can — even a rough "maybe" or "not sure yet" is useful. Leave blanks for things you haven't decided.*
