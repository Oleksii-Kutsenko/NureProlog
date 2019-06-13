implement main
    open core, console, string

class predicates
    deleteSubString : (string, string, string [out]).
clauses
    deleteSubString(String, Substring, Answer) :-
        Answer = replaceAll(String, Substring, "", caseSensitive).

    run() :-
        write("Введите строку:\n"),
        Строка = readLine(),
        clearInput(),
        write("Введите подстроку, вхождения которой удалить\n"),
        Подстрока = readLine(),
        clearInput(),
        deleteSubString(Строка, Подстрока, Answer),
        write(Answer),
        _ = readChar().

end implement main

goal
    console::runUtf8(main::run).
