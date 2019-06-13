% Copyright

implement main
    open core

class predicates
    count_substring : (string String, string Sub, integer Total [out]) nondeterm.
    count_substring : (string String, string Sub, integer Count, integer Total [out]) nondeterm.
    substring_rest : (string String, string Sub, string Rest [out]) determ.

clauses
    count_substring(String, Sub, Total) :-
        count_substring(String, Sub, 0, Total).

    count_substring(String, Sub, Count, Total) :-
        if substring_rest(String, Sub, Rest) then
            NextCount = Count + 1,
            count_substring(Rest, Sub, NextCount, Total)
        else
            Total = Count
        end if.

    substring_rest(String, Sub, Rest) :-
        Position = string::search(String, Sub),
        SubLength = string::length(Sub),
        Length = string::length(String),
        Rest = string::subString(String, Position + SubLength, Length - (Position + SubLength)).

    run() :-
        count_substring("lanabada", "a", Rest),
        stdio::write(Rest),
        _ = stdio::readLine(),
        fail()
        or
        succeed().

end implement main

goal
    console::runUtf8(main::run).
