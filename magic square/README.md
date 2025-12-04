## 🪄 Magic Square Solver in ASP (Answer Set Programming)

This repository contains an implementation of the classic **Magic Square** problem using **Answer Set Programming (ASP)**.

The code declaratively models the fundamental mathematical and combinatorial properties that an $N \times N$ grid must satisfy to be considered "magic."

---

## 🎯 Project Goal

The project has two main objectives:
1.  **Model** the mathematical and combinatorial properties of an $N$-order Magic Square declaratively.
2.  Utilize an **Answer Set Solver** (like `clingo`) to **find** all possible magic squares of a given order.

This project is an excellent practical exercise for understanding:
* **Declarative Programming**: Defining *what* the result must be, rather than *how* to compute it.
* **Constraints and Aggregates**: Effective use of negative constraints and aggregate functions (`#sum`) typical of ASP.
* **Complex Search Problems**: Approaching the efficient resolution of complex combinatorial search problems.

---

## 📜 The ASP Model (`magic_square.lp`)

The program follows the **Generate-Define-Test** paradigm. The code below is designed to be copied directly into the file `magic_square.lp`.

### 1. Generation (Generate)

Defines the domain of indices (`lato`) and values (`valore`) and generates all possible assignments of numbers to cells, ensuring a one-to-one mapping (bijective injection).

```asp
% Base facts (N must be set via #const or -c flag)
lato(1..n).
valore(1..n*n).

% Generation rules: Each cell (X,Y) gets exactly one value (V),
% and each value (V) is assigned to exactly one cell (X,Y).
1 { magic(X,Y,V) : valore(V) } 1 :- lato(X), lato(Y).
1 { magic(X,Y,V) : lato(X), lato(Y) } 1 :- valore(V).



% Definition of Magic Constant (T)
magicval((n*n)*(n*n+1)/(2*n)).

% Calculation of sums
sum_cols(X, S) :- S = #sum{ V : magic(X,L,V), lato(L) }, lato(X).
sum_rows(Y, S) :- S = #sum{ V : magic(L,Y,V), lato(L) }, lato(Y).
sum_diag(1, S) :- S = #sum{ V : magic(L,L,V), lato(L) }.         % Main diagonal (X=Y)
sum_diag(2, S) :- S = #sum{ V : magic(L,N-L+1,V), lato(L) }.     % Anti-diagonal (X+Y = N+1)

% Constraints: All sums must equal the Magic Constant (T)
% Fail if any column sum is not T
:- lato(X), sum_cols(X, V), magicval(T), V != T. 
% Fail if any row sum is not T
:- lato(Y), sum_rows(Y, V), magicval(T), V != T. 
% Fail if any diagonal sum is not T
:- diag(D), sum_diag(D, V), magicval(T), V != T.

### 🚀 Execution Instructions

To run the code, you must have the **clingo** solver installed.

### 1. Requirement

The order $N$ of the square must be specified using the `-c` flag.

### 2. Basic Execution

To find **all solutions** for a **Magic Square of order 3** ($N=3$):

```bash
clingo magic_square.lp -c n=3 -n 0
