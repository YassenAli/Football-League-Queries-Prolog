:- consult(league_data).

member(X, [X|_]).
    member(X, [_|Tail]):-

member(X, Tail).

append([], L, L).
    append([H|T], L2, [H|NT]):-

append(T, L2, NT).

append([], L, L).

append([H|T], L2, [H|NT]):-
	append(T, L2, NT).

member(X, [X|_]).
    member(X, [_|Tail]):-

member(X, Tail).

%% =========================================================.
%% Task 5: count all matches where a specific team participated.
%% =========================================================.

num_matches_of_team(Team, Count) :-
    matches_of_team(Team, List),
    size(N, List).

%% =========================================================
%% Task 6: Find the top goal scorer in the tournament.
%% =========================================================

top_scorer(Player) :-
    goals(Player, Goals),
    \+ (goals(_, OtherGoals), OtherGoals > Goals),
    !.


%% =========================================================
%% Task 7: Find the Most Common Position in a Specific Team
%% =========================================================

most_common_position_in_team(Team, Pos) :-
    players_in_team(Team, Players),
    get_positions(Players, Positions),
    position_frequency(Positions, Freq),
    find_max_freq(Freq, (Pos, _)),
    !.

get_positions([], []).
get_positions([Player | Rest], [Pos | PosRest]) :-
    player(Player, _, Pos),
    get_positions(Rest, PosRest).

position_frequency(Positions, Freq) :-
    position_frequency(Positions, [], Freq).

position_frequency([], Freq, Freq).
position_frequency([Pos | Rest], Acc, Freq) :-
    update_freq(Pos, Acc, NewAcc),
    position_frequency(Rest, NewAcc, Freq).

update_freq(Pos, [], [(Pos, 1)]).
update_freq(Pos, [(Pos, Count) | Rest], [(Pos, NewCount) | Rest]) :-
    NewCount is Count + 1.
update_freq(Pos, [Other | Rest], [Other | NewRest]) :-
    update_freq(Pos, Rest, NewRest).

find_max_freq([(Pos, Count)], (Pos, Count)).
find_max_freq([(Pos, Count) | Rest], Max) :-
    find_max_freq(Rest, (RestPos, RestCount)),
    (Count > RestCount -> Max = (Pos, Count) ; Max = (RestPos, RestCount)).