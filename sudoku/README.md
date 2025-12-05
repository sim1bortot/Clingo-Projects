# 🧩 Sudoku Solver in ASP (Answer Set Programming)

This repository contains a complete model for solving a classical **9×9 Sudoku** using **Answer Set Programming (ASP)**.

The program declaratively models all the constraints that a valid Sudoku solution must satisfy:
- every cell contains exactly one number
- each number appears only once per row
- only once per column
- only once inside each 3×3 subsquare

---

## 🎯 Project Goal

The goal of this project is:

1. **Model** a Sudoku puzzle using declarative constraints in ASP.  
2. Use an **ASP solver** (such as `clingo`) to compute valid solutions.  
3. Demonstrate how ASP lets you express *what* a solution must satisfy instead of *how* to compute it.

---

## 📜 ASP Model (`sudoku.lp`)

The following code is the full ASP model and can be copied directly into `sudoku.lp`.

```asp
coord(1..9).
val(1..9).

% Assign a pair (X,Y) to a subsquare
square(I,X,Y) :-
    coord(X), coord(Y), coord(I),
    I == (X-1) / 3 + 3 * ((Y-1) / 3) + 1.

% x is a function: every cell (X,Y) gets exactly one value N
1 { x(X,Y,N) : val(N) } 1 :- coord(X), coord(Y).

% x is injective on columns
1 { x(X,Y,N) : coord(X) } 1 :- coord(Y), val(N).

% x is injective on rows
1 { x(X,Y,N) : coord(Y) } 1 :- coord(X), val(N).

% x is injective in subsquares
1 { x(X,Y,N) : square(I,X,Y) } 1 :- val(N), coord(I).
```

---

## 🚀 How to Run the Solver

You need to have **clingo** installed:  
https://potassco.org/clingo/

### ▶️ 1. Compute all possible solutions
```bash
clingo sudoku.lp -n 0
```

### ▶️ 2. Add Sudoku clues (givens)

You can add clues at the bottom of `sudoku.lp`:

```asp
x(1,1,5).
x(3,4,7).
x(9,2,1).
```

Then run:

```bash
clingo sudoku.lp
```

### ▶️ 3. Request only one solution
```bash
clingo sudoku.lp -n 1
```

---

## 📦 Repository Structure

```
📁 sudoku/
 ├── sudoku.lp
 └── README.md
```

