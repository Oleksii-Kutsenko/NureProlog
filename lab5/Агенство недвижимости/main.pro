% Copyright

implement main
    open core

class facts - real_estate_db
    real_estate : (string Type, string Location, string District, string Subway, string Num_Rooms, string Floor, string Num_Floors, string Price,
        string Square).

class predicates
    upload_db : ().
    member : (string, string*) nondeterm.
    set_real_estate_type : (string Type [out]) nondeterm.
    set_real_estate_location : (string Type, string Location [out]) nondeterm.
    set_real_estate_district : (string Type, string Location, string District [out]) nondeterm.
    set_real_estate_subway : (string Type, string Location, string District, string Subway [out]) nondeterm.
    set_real_estate_rooms : (string Type, string Location, string District, string Subway, string Rooms [out]) nondeterm.
    set_real_estate_price : (string Type, string Location, string District, string Subway, string Rooms) nondeterm.
    set_real_estate_price : (string Type, string Location, string District, string Subway, string Rooms, string Floor, string Floors) nondeterm.
    set_real_estate_square : (string Type, string Location, string District, string Subway, string Rooms, string Price) nondeterm.
    set_real_estate_square : (string Type, string Location, string District, string Subway, string Rooms, string Floor, string Floors, string Price)
        nondeterm.
    set_real_estate_floors : (string Type, string Location, string District, string Subway, string Rooms) nondeterm.
    print_list : (string** Result) nondeterm.
    print_head : (string* Real_Estate) determ.
    equal : (string, string) determ.

clauses
    equal(X, X).

    print_head([Type, Location, District, Subway, Num_Rooms, Floor, Num_Floors, Price, Square]) :-
        console::write("Type: ", Type, " |Location: ", Location, " |District: ", District, " |Subway: ", Subway, " |Number of rooms: ", Num_Rooms,
            " |Floor: ", Floor, " |Number of floors: ", Num_Floors, " |Price: ", Price, " |Square: ", Square, "\n").

    print_list([Head]) :-
        print_head(Head),
        !.
    print_list([Head | Tail]) :-
        print_head(Head),
        print_list(Tail).

    upload_db() :-
        file::consult'Ваш_путь_к_файлу_db.txt', real_estate_db).

    member(Elem, [Elem | _Tail]).
    member(Elem, [_Head | Tail]) :-
        member(Elem, Tail).

    set_real_estate_type(Type) :-
        List = list::removeDuplicates([ X || real_estate(X, _, _, _, _, _, _, _, _) ]),
        console::write("Hello there! Please select which type of real estate you want: ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            Type = X,
            console::write("Success type of real estate set. Do you want to set city? Y/n\n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                console::write(""),
                print_list([ [Type, A, B, C, D, E, F, G, H] || real_estate(Type, A, B, C, D, E, F, G, H) ]),
                !
            else
                set_real_estate_location(Type, _Location)
            end if
        else
            console::write("Error: no such type of real estate\n"),
            set_real_estate_type(Type)
        end if.

    set_real_estate_location(Type, Location) :-
        List = list::removeDuplicates([ X || real_estate(Type, X, _, _, _, _, _, _, _) ]),
        console::write("Please select city where you want to buy real estate from list ", List, " \n"),
        X = console::readLine(),
        if member(X, List) then
            Location = X,
            console::write("Success real estate location set. Do you want to set district? Y/n\n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                print_list([ [Type, Location, B, C, D, E, F, G, H] || real_estate(Type, Location, B, C, D, E, F, G, H) ]),
                !
            else
                set_real_estate_district(Type, Location, _District)
            end if
        else
            console::write("Error: no such sity\n"),
            set_real_estate_location(Type, Location)
        end if.

    set_real_estate_district(Type, Location, District) :-
        List = list::removeDuplicates([ X || real_estate(Type, Location, X, _, _, _, _, _, _) ]),
        console::write("Please select ", Location, "'s district where you want to buy real estate from list ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            District = X,
            console::write("Success real estate district set. Do you want to choose subway station? Y/n\n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                print_list([ [Type, Location, District, C, D, E, F, G, H] || real_estate(Type, Location, District, C, D, E, F, G, H) ]),
                !
            else
                set_real_estate_subway(Type, Location, District, _Subway)
            end if
        else
            console::write("Error: no such district\n"),
            set_real_estate_district(Type, Location, District)
        end if.

    set_real_estate_subway(Type, Location, District, Subway) :-
        List = list::removeDuplicates([ X || real_estate(Type, Location, District, X, _, _, _, _, _) ]),
        console::write("Please select subway from list ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            Subway = X,
            console::write("Success real state subway set. Do you want to choose number of rooms? Y/n \n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                print_list([ [Type, Location, District, Subway, D, E, F, G, H] || real_estate(Type, Location, District, Subway, D, E, F, G, H) ]),
                !
            else
                set_real_estate_rooms(Type, Location, District, Subway, _Rooms)
            end if
        else
            console::write("Error: no such subway\n"),
            set_real_estate_subway(Type, Location, District, Subway)
        end if.

    set_real_estate_rooms(Type, Location, District, Subway, Rooms) :-
        if equal(Type, "Plot of land") then
            Rooms = "No rooms",
            console::write(
                "Your real estate type is plot of land, so there are no rooms in it. Do you want to choose max price of your real estate? Y/n\n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                print_list(
                    [ [Type, Location, District, Subway, Rooms, E, F, G, H] || real_estate(Type, Location, District, Subway, Rooms, E, F, G, H) ]),
                !
            else
                set_real_estate_price(Type, Location, District, Subway, Rooms)
            end if
        else
            List = list::removeDuplicates([ X || real_estate(Type, Location, District, Subway, X, _, _, _, _) ]),
            console::write("Please select number of rooms from list ", List, "\n"),
            X = console::readLine(),
            if member(X, List) then
                Rooms = X,
                console::write("Success number of rooms set. Do you want to choose floors of your real estate? Y/n\n"),
                Ans = console::readLine(),
                if equal(Ans, "n") then
                    print_list(
                        [ [Type, Location, District, Subway, Rooms, E, F, G, H] || real_estate(Type, Location, District, Subway, Rooms, E, F, G, H) ]),
                    !
                else
                    set_real_estate_floors(Type, Location, District, Subway, Rooms)
                end if
            else
                console::write("Error: no such number of rooms\n"),
                set_real_estate_rooms(Type, Location, District, Subway, Rooms)
            end if
        end if.

    set_real_estate_price(Type, Location, District, Subway, Rooms) :-
        List = list::removeDuplicates([ X || real_estate(Type, Location, District, Subway, Rooms, _, _, X, _) ]),
        console::write("Please select max price from list ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            Price = X,
            console::write("Success max price set. Do you want to choose square of real estate? Y/n\n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                print_list(
                    [ [Type, Location, District, Subway, Rooms, E, F, G, H] ||
                        real_estate(Type, Location, District, Subway, Rooms, E, F, G, H),
                        toTerm(integer, G) <= toTerm(integer, Price)
                    ]),
                !
            else
                set_real_estate_square(Type, Location, District, Subway, Rooms, Price)
            end if
        end if.

    set_real_estate_price(Type, Location, District, Subway, Rooms, Floor, Floors) :-
        List = list::removeDuplicates([ X || real_estate(Type, Location, District, Subway, Rooms, Floor, Floors, X, _) ]),
        console::write("Please select max price from list ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            Price = X,
            console::write("Success max price set. Do you want to choose square of real estate? Y/n\n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                print_list(
                    [ [Type, Location, District, Subway, Rooms, E, F, G, H] ||
                        real_estate(Type, Location, District, Subway, Rooms, E, F, G, H),
                        toTerm(integer, G) <= toTerm(integer, Price)
                    ]),
                !
            else
                set_real_estate_square(Type, Location, District, Subway, Rooms, Floor, Floors, Price)
            end if
        end if.

    set_real_estate_square(Type, Location, District, Subway, Rooms, Price) :-
        List =
            list::removeDuplicates(
                [ H ||
                    real_estate(Type, Location, District, Subway, Rooms, _E, _F, G, H),
                    toTerm(integer, G) <= toTerm(integer, Price)
                ]),
        console::write("Please select square size from list ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            console::write("Real estate choosed based on your preferences\n"),
            print_list(
                [ [Type, Location, District, Subway, Rooms, E, F, G, X] ||
                    real_estate(Type, Location, District, Subway, Rooms, E, F, G, X),
                    toTerm(integer, G) <= toTerm(integer, Price)
                ])
        end if.

    set_real_estate_square(Type, Location, District, Subway, Rooms, Floor, Floors, Price) :-
        List =
            list::removeDuplicates(
                [ H ||
                    real_estate(Type, Location, District, Subway, Rooms, Floor, Floors, G, H),
                    toTerm(integer, G) <= toTerm(integer, Price)
                ]),
        console::write("Please select square size from list ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            console::write("Real estate choosed based on your preferences\n"),
            print_list(
                [ [Type, Location, District, Subway, Rooms, Floor, Floors, Price, X] ||
                    real_estate(Type, Location, District, Subway, Rooms, Floor, Floors, Y, X),
                    toTerm(integer, Y) <= toTerm(integer, Price)
                ])
        end if.

    set_real_estate_floors(Type, Location, District, Subway, Rooms) :-
        List =
            list::removeDuplicates(
                [ string::concat(Floor, "/", Floors) || real_estate(Type, Location, District, Subway, Rooms, Floor, Floors, G, H) ]),
        console::write("Please select floors from list: ", List, "\n"),
        X = console::readLine(),
        if member(X, List) then
            [Floor, Floors] = string::split(X, "/"),
            console::write("Real estate floors set. Do you want to choose max price of your real estate? Y/n\n"),
            Ans = console::readLine(),
            if equal(Ans, "n") then
                print_list(
                    [ [Type, Location, District, Subway, Rooms, Floor, Floors, G, X] ||
                        real_estate(Type, Location, District, Subway, Rooms, Floor, Floors, G, X)
                    ])
            else
                set_real_estate_price(Type, Location, District, Subway, Rooms, Floor, Floors)
            end if
        else
            set_real_estate_floors(Type, Location, District, Subway, Rooms)
        end if.
        % run
    run() :-
        upload_db(),
        set_real_estate_type(Type),
        _ = console::readLine(),
        fail()
        or
        _ = console::readLine().

end implement main

goal
    console::runUtf8(main::run).
