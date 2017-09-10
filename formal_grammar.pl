/* Databaza */
/*   podstatne mena v nominative */
nomin("zena").
nomin("ruze").
nomin("pisen").
nomin("kost").

/*   podstatne mena v akuzative */
akuz("zenu").
akuz("ruzi").
akuz("pisen").
akuz("kost").

/*   pridavne mena */
adj("krasnou").
adj("tvrdou").
adj("ostrou").

/*   slovesa */
verb("zpiva").
verb("vidi").
verb("vari").

/* Hlavny algoritmus */
isCorrectSentence(Veta) :- splitString(Veta,SplitVeta), veta(SplitVeta), !.
/*   transformacia vety (stringu) na list stringov 
     oddelovace su medzery*/
splitString(X,L) :- split_string(X," ","",L).

/* Struktura vety: Podmet ++ Prisudok ++ Predmet */
veta(Veta) :- append([X,Y,Z],Veta), podmet(X), prisudok(Y), predmet(Z).

/* Struktura vedlajsej vety: "ktera" ++ Prisudok ++ Predmet */
vedlajsiaVeta(X) :- append([ ["ktera"], Pris, Pred ],X), prisudok(Pris), predmet(Pred).

/* Struktura podmetu: podstatne meno v nominative | podstatne meno v nominative ++ "," ++ vedlajsia veta ++ "," */
podmet([X]) :- nomin(X).
podmet(X) :- append([ [Nomin], [","], Vedl, [","] ],X), nomin(Nomin), vedlajsiaVeta(Vedl).

/* Struktura prisduku: sloveso */
prisudok([X]) :- verb(X).

/* Struktura predmetu: sloveso v akuzative | sloveso v akuzative ++ "," ++ veldajsia veta | pridavne meno ++ Predmet */
predmet([X]) :- akuz(X).
predmet(X) :- append([ [Akuz], [","], Vedl ],X), akuz(Akuz), vedlajsiaVeta(Vedl).
predmet(X) :- append([ [Adj], Predm ],X), adj(Adj), predmet(Predm).