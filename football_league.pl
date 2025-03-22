:- consult(league_data).

% ======================= HELPER PREDICATES ======================= %
% Member: Check if X is in a list
member(X, [X|_]) :- !.
member(X, [_|Tail]) :-
    member(X, Tail).

% Append: Concatenate two lists
append([], L, L) :- !.
append([H|T], L2, [H|NT]) :-
    append(T, L2, NT), !.

% List length: Calculate the length of a list
list_length([], 0) :- !.
list_length([_|T], N) :-
    list_length(T, N1),
    N is N1 + 1, !.

% ======================= TASK 4 ======================= %
% List all matches where a team participated (with goals)
matches_of_team(Team, Matches) :-
    find_matches(Team, [], Matches), !.

find_matches(Team, Acc, Matches) :-
    (   match(Team, Opponent, G1, G2),
        \+ member((Team, Opponent, G1, G2), Acc),
        append(Acc, [(Team, Opponent, G1, G2)], NewAcc),
        find_matches(Team, NewAcc, Matches), !
    ;   match(Opponent, Team, G1, G2),
        \+ member((Opponent, Team, G1, G2), Acc),
        append(Acc, [(Opponent, Team, G1, G2)], NewAcc),
        find_matches(Team, NewAcc, Matches), !
    ),
    !.
find_matches(_, Matches, Matches) :- !.

% ======================= TASK 5 ======================= %
% Count matches for a team
num_matches_of_team(Team, Count) :-
    matches_of_team(Team, List),
    list_length(List, Count), !.

% ======================= TASK 6 ======================= %
% Find top goal scorer
top_scorer(Player) :-
    goals(Player, Goals),
    \+ (goals(_, OtherGoals), OtherGoals > Goals),
    !.

% ======================= TASK 7 ======================= %
% Most common position in a team
most_common_position_in_team(Team, Pos) :-
    players_in_team(Team, Players),
    get_positions(Players, Positions),
    position_frequency(Positions, Freq),
    find_max_freq(Freq, (Pos, _)),
    !.

players_in_team(Team, Players) :-
    find_players(Team, [], Players), !.

find_players(Team, Acc, Players) :-
    player(Name, Team, _),
    \+ member(Name, Acc),
    append(Acc, [Name], NewAcc),
    find_players(Team, NewAcc, Players), !.
find_players(_, Players, Players) :- !.

get_positions([], []) :- !.
get_positions([Player | Rest], [Pos | PosRest]) :-
    player(Player, _, Pos),
    get_positions(Rest, PosRest), !.

position_frequency(Positions, Freq) :-
    position_frequency(Positions, [], Freq), !.

position_frequency([], Freq, Freq) :- !.
position_frequency([Pos | Rest], Acc, Freq) :-
    update_freq(Pos, Acc, NewAcc),
    position_frequency(Rest, NewAcc, Freq), !.

update_freq(Pos, [], [(Pos, 1)]) :- !.
update_freq(Pos, [(Pos, Count) | Rest], [(Pos, NewCount) | Rest]) :-
    NewCount is Count + 1, !.
update_freq(Pos, [Other | Rest], [Other | NewRest]) :-
    update_freq(Pos, Rest, NewRest), !.

find_max_freq([(Pos, Count)], (Pos, Count)) :- !.
find_max_freq([(Pos, Count) | Rest], Max) :-
    find_max_freq(Rest, (RestPos, RestCount)),
    (Count > RestCount -> Max = (Pos, Count) ; Max = (RestPos, RestCount)), !.

% ======================= TASK 2 ======================= %
% Count teams from a country
team_count_by_country(Country, Count) :-
    find_teams_by_country(Country, Teams),
    list_length(Teams, Count), !.

find_teams_by_country(Country, Teams) :-
    find_teams(Country, [], Teams), !.

find_teams(Country, Acc, Teams) :-
    team(Name, Country, _),
    \+ member(Name, Acc),
    append(Acc, [Name], NewAcc),
    find_teams(Country, NewAcc, Teams), !.
find_teams(_, Teams, Teams) :- !.

% ======================= TASK 1 ======================= %
players_in_team(Team, Players) :-
    players_in_team_acc(Team, [], Players).

players_in_team_acc(Team, Acc, Players) :-
    player(Name, Team, _),
    \+ member(Name, Acc),
    !,
    append(Acc, [Name], NewAcc),
    players_in_team_acc(Team, NewAcc, Players).
players_in_team_acc(_, Players, Players).

% ======================= TASK 3 ======================= %
most_successful_team(Team) :-
    most_successful_team_calc(none, 0, [], Team).


most_successful_team_calc(CurrentTeam, CurrentMax, Processed, FinalTeam) :-
    team(Name, _, Wins),
    \+ member(Name, Processed),
    !,
    (Wins > CurrentMax ->
        NewMax = Wins,
        NewTeam = Name
    ;
        NewMax = CurrentMax,
        NewTeam = CurrentTeam
    ),
    append(Processed, [Name], NewProcessed),
    most_successful_team_calc(NewTeam, NewMax, NewProcessed, FinalTeam).

most_successful_team_calc(FinalTeam, _, _, FinalTeam).
