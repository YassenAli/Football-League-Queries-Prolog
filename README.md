# Football-League-Queries-Prolog

## Overview

This project is a Prolog assignment for our AI course. The goal is to query a football league database using Prolog predicates. The database is defined in the `league_data.pl` file, which contains facts about teams, players, matches, and goals.

## Assignment Details

The program must answer the following queries:

1. **List all players in a specific team:**  
   Predicate: `players_in_team/2`  
   Example: `?- players_in_team(barcelona, L).`

2. **Count teams from a specific country:**  
   Predicate: `team_count_by_country/2`  
   Example: `?- team_count_by_country(spain, N).`

3. **Find the team with the most championship titles:**  
   Predicate: `most_successful_team/1`  
   Example: `?- most_successful_team(T).`

4. **List all matches where a specific team participated:**  
   Predicate: `matches_of_team/2`  
   Example: `?- matches_of_team(barcelona, L).`

5. **Count all matches where a specific team participated:**  
   Predicate: `num_matches_of_team/2`  
   Example: `?- num_matches_of_team(barcelona, N).`

6. **Find the top goal scorer in the tournament:**  
   Predicate: `top_scorer/1`  
   Example: `?- top_scorer(P).`

7. **Find the most common position in a specific team:**  
   Predicate: `most_common_position_in_team/2`  
   Example: `?- most_common_position_in_team(barcelona, Pos).`

8. **Bonus Task:**  
   Ensure that the predicates do not allow unnecessary backtracking to produce extra answers.

## Project Structure
```
|-- league_data.pl  # Contains the given facts about teams, players, and matches
|-- football_league.pl  # Contains Prolog predicates to solve assignment tasks
|-- README.md  # Project documentation
```

## Setup Instructions
1. Install SWI-Prolog (if not already installed):
   ```sh
   sudo apt install swi-prolog  # Linux
   brew install swi-prolog      # macOS
   ```
   Windows users can download it from [SWI-Prolog official site](https://www.swi-prolog.org/).

2. Clone this repository:
   ```sh
   git clone https://github.com/Football-League-Queries-Prolog.git
   cd Football-League-Queries-Prolog
   ```

3. Open SWI-Prolog and consult the knowledge base:
   ```prolog
   ?- consult(league_data).
   ?- consult(football_league).
   ```

## License
This project is for educational purposes only as part of the AI course at **Faculty of Computers and Artificial Intelligence, Cairo University**.
