what_grade(5) :-
	write('Go to K').

what_grade(6) :-
	write('GO PLAY PIANO').

what_grade(Other) :-
	Grade is Other - 5,
	format('Go to Grade ~w', [Grade]).