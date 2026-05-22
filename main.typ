#import "mldisplay.typ": mldisplay
#import "lib.typ": ieee

#show: ieee.with(
  title: [Diseño de un lenguaje],
  summary: [
    Este informe narra la investigación, decisiones tomadas y problemas
    abordados a la hora de diseñar un lenguaje de programación.
  ],
  authors: (
    (
      name: "Hugo Coto",
      department: [Independent Researcher],
      location: [Santiago de Compostela, España],
      email: "hugo@hugocoto.com",
    ),
  ),
  index-terms: none,
  bibliography: bibliography("refs.bib"),
  paper-size: "us-letter",
  lang: "en",
  date: mldisplay(datetime.today(), "[weekday repr:long], [day] of [month repr:long] [year]"),
  aside: [Language designed and written by Hugo Coto Flórez],
)

= Introduction

= Programming Language Design: Executive Summary


== I. Resolved Specifications

=== Purpose and Architectural Philosophy
- Conceived as a general-purpose, exploratory research language; not intended for commercial market competition.
- Semantic expressiveness and structural simplicity are prioritized over raw computational performance or strict safety enforcement.
- Designed for experienced developers; intentionally eschews beginner-focused ergonomics.
- Programmatic correctness is strictly enforced by the compiler, minimizing reliance on developer discretion.
- Established as a strictly open-source initiative without corporate sponsorship, targeting stable evolutionary cycles and maintaining backward compatibility as a soft objective.
- The formulation of a mathematically rigorous specification and a canonical reference implementation is planned.

=== Execution and Compilation Model
- Compiles natively via LLVM, utilizing LLVM Intermediate Representation (IR) as the primary compilation target.
- Execution is strictly Ahead-Of-Time (AOT); Just-In-Time (JIT) compilation, interpreters, and REPL environments are excluded from the current scope.
- The LLVM IR serves as the explicitly exposed intermediate representation.
- Leverages LLVM's native capabilities for Tail-Call Optimization (TCO), Single Instruction Multiple Data (SIMD) vectorization, and Link-Time Optimization (LTO) implicitly.

=== Type System Architecture
- Employs strict static typing complemented by comprehensive type inference, rendering explicit type annotations largely optional.
- Enforces a strong typing discipline designed to remain syntactically ergonomic.
- Supports parametric polymorphism (generics) for both data structures and functions.
- Integrates tagged union types _(e.g., `A | B` with runtime tag tracking)_ as a foundational architectural feature.
- Supports intersection types, permitting values to satisfy multiple type constraints concurrently.
- Strictly prohibits `null`, `nil`, or `undefined` states; data absence is modeled formally via the type system.
- Omits traditional algebraic data types (ADTs) in favor of the aforementioned tagged unions.
- Facilitates compile-time type generation and type-level programming capabilities.
- A `void` or `unit` type is tentatively supported for side-effectful expressions, though not positioned as a core abstraction.

=== Memory Management Architecture
- Memory is deterministically managed by the compiler via lexical scopes and lifetimes, adopting a more implicit approach than traditional borrow checkers.
- Strictly excludes garbage collection, reference counting mechanisms, and smart pointer abstractions.
- Stack allocation serves as the default behavior; heap allocations are provisioned implicitly by the compiler when required.
- Guarantees inherent memory safety by design; explicitly excludes an `unsafe` escape hatch or raw pointer manipulation, thereby precluding buffer overflows and null pointer dereferencing.
- Custom memory allocators are excluded from the initial specification.
- Region-based memory management (arenas) may be relegated to standard library implementations rather than core language primitives.

=== Paradigms and Object Model
- Adopts an expression-oriented paradigm wherein nearly all constructs evaluate to a return value.
- Eschews traditional object-oriented programming (OOP) mechanics, excluding class structures and inheritance hierarchies.
- Utilizes structural records (structs) as the primary mechanism for data encapsulation.
- Prioritizes composition over inheritance for behavioral extension.
- Implements interfaces or behavioral traits strictly through composition rather than explicit contractual definitions.
- Enforces strict encapsulation: module constituents are private by default and explicitly exported via a `pub` directive.
- Method definitions on structs require an explicit `self` reference.
- Strictly prohibits abstract classes, virtual methods, and method overriding.

=== Functional Programming Capabilities
- Functions are formalized as first-class entities.
- Anonymous functions (lambdas) are natively supported and established as the idiomatic construct for concise logic.
- Excludes function currying and partial application to maintain structural simplicity.
- Higher-order functions _(e.g., map, filter, reduce)_ are relegated to the standard library rather than intrinsic language keywords.
- Function composition is highly idiomatic, facilitated by a dedicated pipeline operator.
- Excludes pure function annotations and formalized effect systems.
- Closures are tentatively supported, though variable capture semantics remain undefined.

=== Operators and Expressions
- Explicitly prohibits operator overloading and user-defined operators to minimize semantic complexity.
- Assignments are evaluated as expressions yielding a value.
- Implements standard operator precedence rules, negating the requirement for exhaustive parenthesization.
- Integrates a pipeline operator _(`->`)_ to facilitate sequential, left-to-right function chaining.
- Natively supports spread/splat operators for variadic contexts.
- Omits null-coalescing and optional chaining operators as a logical consequence of null-safety guarantees.

=== Control Flow Mechanisms
- Evaluates conditional `if / else` branching as value-yielding expressions.
- Provides a `match` construct for exhaustive, compiler-verified type-based and value-based pattern matching.
- Supports named loop labels to facilitate explicit structural breakouts from nested iterations.
- Supports structured early return paradigms _(e.g., guard clauses)_.
- Natively integrates generators, coroutines, and first-class iterators.

=== Syntactic Design and Aesthetics
- Syntactic lineage is drawn from a synthesis of Rust, Haskell, OCaml, and C.
- Whitespace and indentation are purely cosmetic and syntactically insignificant.
- Parentheses are not mandated around conditional predicates in `if` or `while` constructs.
- Permits trailing commas in list declarations.
- Enforces strict case sensitivity.
- Establishes `snake_case` as the canonical identifier naming convention.
- Prioritizes syntactic brevity over verbosity, minimizing keyword proliferation in favor of contextual symbols.

=== Modularity and Packaging
- Implements a minimalist, pragmatic module system.
- Facilitates selective import directives for precise scope management.
- Enforces module-level visibility rules _(private by default, exposed via `pub`)_.
- Includes a built-in project management utility, distinct from comprehensive external dependency managers.

=== Interoperability
- Provides a native C Foreign Function Interface (FFI) utilizing the SysV ABI for compatibility with Linux shared libraries (`.so`).
- Explicitly excludes interoperability with managed runtimes _(e.g., JVM, CLR, Node.js)_.

=== Data Structures and Collections
- Natively supports fixed-size, heterogeneous tuples.
- Natively supports dynamically resizable arrays.
- Natively supports associative dictionaries/maps.
- Mandates strict generic typing across all standard collections.

=== Safety and Security Assurances
- Enforces rigorous, automated bounds checking on all array accesses.
- Structurally eliminates null pointer dereferencing and uninitialized variable states at compile-time.
- Treats arithmetic integer overflows as silent wrapping in release builds.
- Maintains a universally safe execution environment devoid of manual unsafe execution contexts.

=== Toolchain Ecosystem
- Currently implements an official build system and documentation generator.
- Plans for the future integration of a formatter, static linter, test runner, debugger, and Language Server Protocol (LSP) support.

=== Standard Library
- Designed to scale progressively from a minimal core to a comprehensive ecosystem encompassing collections, text manipulation, I/O, cryptography, networking, concurrency, serialization, regular expressions, and unit testing.


== II. Undetermined Specifications

- *Error Handling Semantics:* The mechanism for failure propagation remains unresolved in the absence of exceptions and nulls. Options under evaluation include monadic result types _(e.g., `Ok | Err`)_, multiple return values, explicit `defer` mechanisms, and syntactic propagation operators _(e.g., `?`)_.
- *Closure Capture Semantics:* While lambda expressions are confirmed, the memory semantics governing variable capture _(by-value copy, by-reference, or by-move)_ require reconciliation with the lifetime model.
- *Iterative Syntax:* The precise lexical forms for loop constructs _(`for`, `while`, `foreach`, `do-while`)_ and control directives _(`break`, `continue`)_ remain unspecified.
- *Instance Reference (`self`) Convention:* The formal positioning of methods—whether explicitly bound to structs via a receiver or defined as free functions accepting the struct as a primary argument—is pending finalization.
- *Typing Discipline (Structural vs. Nominal):* The extent to which composition relies on structural compatibility _(duck typing)_ versus explicit nominal declarations requires formal definition.
- *Statement Termination:* The mandate, optionality, or automated inference of semicolons is undecided.
- *Bitwise Operations:* The inclusion of native bitwise manipulation operators is unconfirmed.
- *Unit Type Semantics:* The formal representation and necessity of a `void` or `unit` type for evaluating side-effectful expressions requires clarification.
- *Concurrency Architecture:* While type-level data-race freedom and atomic types are goals, the underlying execution model _(e.g., OS threads, green threads, message-passing channels, or shared memory)_ remains undefined.
- *Intersection Type Mechanics:* The concrete operational semantics of intersection types _(`A & B`)_—specifically concerning field resolution and composition conflicts—must be rigorously defined.
- *Pattern Matching Scope:* It is undetermined whether the `match` construct will operate exclusively on runtime values, type definitions, or a synthesis of both.
- *Opaque Types (Newtypes):* The inclusion of zero-cost abstraction wrappers for strict type safety _(e.g., distinguishing `f64` metrics)_ is under consideration.
- *String Architecture:* Decisions regarding string immutability, underlying encoding _(e.g., UTF-8 vs. raw bytes)_, interpolation syntax, multiline definitions, and the distinction of a `char` type are pending.
- *Standard Library Collections:* The inclusion of sets, queues, and stacks within the standard library is anticipated but not formally committed.
- *Lazy Evaluation:* The integration of lazily evaluated sequences and their interaction with the iterator protocol requires further analysis.
- *Integer Overflow Trapping:* The current decision to permit silent wrapping conflicts with the overarching mandate for absolute programmatic safety and warrants deliberate reevaluation.
- *Ternary Operator:* The necessity of a distinct ternary operator is questioned given the expression-oriented nature of `if` constructs.
- *Metaprogramming Capabilities:* The scope of compile-time execution, macros, runtime reflection, and syntactic decorators remains entirely open.
- *Custom Memory Allocators:* Support for user-defined allocators is tentatively excluded but subject to review.
- *WebAssembly (WASM) Compilation:* Targeting WASM is recognized as an exploratory interest rather than an immediate architectural objective.

