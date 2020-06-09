loves(rocky, emily).
loves(emily, rocky) :- loves(rocky, emily).

male(superman).
male(batman).
male(robin).
male(flash).
male(aquaman).

female(wonderwoman).
female(hawkgirl).
female(supergirl).
female(starfire).
female(batgirl).

parent(superman, robin).
parent(superman, starfire).
parent(superman, hawkgirl).

parent(hawkgirl, supergirl).

parent(wonderwoman, robin).
parent(wonderwoman, starfire).
parent(wonderwoman, batman).

parent(aquaman, batman).

parent(batman, flash).
parent(batman, batgirl).

parent(supergirl, flash).
parent(supergirl, batgirl).

get_grandparent :-
	parent(X, flash),
	parent(X, batgirl),
	parent(Y, X),
	format('~w ~s parent of flash and batgirl ~n', [X, "is the"]),
	format('~w ~s parent of ~w ~n', [Y, "is the", X]).

brother(batman, robin).


grand_parent(X, Y) :-
	parent(Z, X),
	parent(Y, Z).

