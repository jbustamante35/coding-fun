happy(albert).
happy(janice).
happy(lola).
happy(shanefrancus).

with_albert(janice).
near_water(shanefrancus).


runs(albert) :-
	happy(albert).

dances(janice). :-
	happy(janice),
	with_albert(janice).

does_janice_dance :- dances(janice),
	write('When Janice is happy and with Albert, she dances').

swims(shanefrancus) :-
	happy(shanefrancus),
	near_water(shanefrancus).


yells(janice, X) :- tackles(X, lola, downstairs).
tackles(shanefrancus, lola, downstairs).

