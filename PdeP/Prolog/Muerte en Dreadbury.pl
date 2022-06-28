% Muerte en la Mansión Dreadbury

viveEnMansionDreadbury(tiaAgatha).
viveEnMansionDreadbury(elMayordomo).
viveEnMansionDreadbury(charles).

/* Como base de conocimiento (Idea descartada):

    odiaA(tiaAgatha, charles).
    odiaA(elMayordomo, charles).
    odiaA(charles, elMayordomo).
    odiaA(charles, tiaAgatha).
*/

odiaA(tiaAgatha, Persona) :-
    viveEnMansionDreadbury(Persona),
    Persona \= elMayordomo.

odiaA(elMayordomo, Persona) :-
    odiaA(tiaAgatha, Persona).

odiaA(charles, Persona) :-
    viveEnMansionDreadbury(Persona),
    not(odiaA(tiaAgatha, Persona)).

esMasRicoQueTiaAgatha(Persona) :-
    not(odiaA(elMayordomo, Persona)),
    viveEnMansionDreadbury(Persona).

matoA(Asesino, Victima) :-
    odiaA(Asesino, Victima),
    not(esMasRicoQueTiaAgatha(Asesino)),
    viveEnMansionDreadbury(Asesino).

odiaAAlguien(Persona1, Persona2) :-             % También responde quién odia a quién
    odiaA(Persona1, Persona2).

/*
    Intenté esto para devolver a todos los odiadores pero no encuentro una forma de devolver a todos los odiadores y a quién odia cada uno.

        todosLosOdiadores(Persona) :-
            odiaAAlguien(Persona, _).
*/

/*
    1. b.
        1 ?- matoA(elMayordomo, tiaAgatha).
        false.

        2 ?- matoA(charles, tiaAgatha).       
        false.

        3 ?- matoA(tiaAgatha, tiaAgatha).  
        true.

    2.  Existe alguien que odie a milhouse?
        
            4 ?- odiaAAlguien(_, milhouse).
            false.
        
        A quién odia charles?

            5 ?- odiaAAlguien(charles, OdiaA).
            OdiaA = elMayordomo ;
            false.

        El nombre de quien odia a Tia Ágatha

            6 ?- odiaAAlguien(Persona, tiaAgatha).
            Persona = tiaAgatha;
            Persona = elMayordomo.
        
        El mayordomo odia a alguien?
    
            7 ?- odiaAAlguien(elMayordomo, Persona).
            Persona = tiaAgatha;
            Persona = charles.
*/