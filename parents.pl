:- encoding(utf8).      % Установить кодировку UTF-8, чтобы можно было работать с русскими символами

% Факты, описывающие генеалогическое древо
man("Алексей Михайлович").
man("Иван V").
man("Карл-Фридрих").
man("Петр I").
man("Алексей Петрович").
man("Петр II").
man("Петр III").
man("Павел I").
man("Александр I").
man("Константин Павлович").
woman("Мария Милославская").
woman("Наталья Нарышкина").
woman("Софья").
woman("Прасковья Салтыкова").
woman("Евдокия Лопухина").
woman("Екатерина I").
woman("Анна Иоановна").
woman("Елизавета Петровна").
woman("Анна Петровна").
woman("Софья-Шарлотта").
woman("Екатерина II").
woman("Наталья Алексеевна").
woman("Мария Федоровна").
woman("Елизавета Алексеевна").
woman("Софья Алексеевна").
pair("Алексей Михайлович", "Мария Милославская").
pair("Алексей Михайлович", "Наталья Нарышкина").
pair("Иван V", "Прасковья Салтыкова").
pair("Петр I", "Евдокия Лопухина").
pair("Петр I", "Екатерина I").
pair("Карл-Фридрих", "Анна Петровна").
pair("Алексей Петрович", "Софья-Шарлотта").
pair("Екатерина II", "Петр III").
pair("Павел I", "Наталья Алексеевна").
pair("Павел I", "Мария Федоровна").
pair("Александр I", "Елизавета Алексеевна").
child("Софья Алексеевна", "Мария Милославская").
child("Иван V", "Мария Милославская").
child("Софья Алексеевна", "Алексей Михайлович").
child("Иван V", "Алексей Михайлович").
child("Петр I", "Алексей Михайлович").
child("Петр I", "Наталья Нарышкина").
child("Наталья Алексеевна", "Алексей Михайлович").
child("Наталья Алексеевна", "Наталья Нарышкина").
child("Анна Иоановна", "Иван V").
child("Анна Иоановна", "Прасковья Салтыкова").
child("Алексей Петрович", "Петр I").
child("Алексей Петрович", "Евдокия Лопухина").
child("Анна Петровна", "Петр I").
child("Анна Петровна", "Екатерина I").
child("Елизавета Петровна", "Петр I").
child("Елизавета Петровна", "Екатерина I").
child("Петр II", "Алексей Петрович").
child("Петр II", "Софья-Шарлотта").
child("Петр III", "Карл-Фридрих").
child("Петр III", "Анна Петровна").
child("Павел I", "Екатерина II").
child("Павел I", "Петр III").
child("Константин Павлович", "Павел I").
child("Константин Павлович", "Мария Федоровна").
child("Александр I", "Павел I").
child("Александр I", "Мария Федоровна").

% Описание правил

mother(Child, Mother) :- woman(Mother), child(Child, Mother).
father(Child, Father) :- man(Father), child(Child, Father).
grandson(Grandson, Grandparent) :- man(Grandson), child(Grandson, Parent), child(Parent, Grandparent).

exactly_one_same_parent(A, B) :- child(A, P1), child(B, P1), child(A, P2), not(child(B, P2)).
exactly_two_same_parent(A, B) :- child(A, P1), child(B, P1), child(A, P2), child(B, P2), man(P1), woman(P2).
at_least_one_same_parent(A, B) :- exactly_one_same_parent(A, B); exactly_two_same_parent(A, B).
sibling(Person, Sibling) :- at_least_one_same_parent(Person, Sibling), Person\=Sibling.
brother(Brother, Sibling) :- sibling(Brother, Sibling), man(Brother).
sister(Sister, Sibling) :- sibling(Sister, Sibling), woman(Sister).

aunt(Person, Aunt) :- child(Person, Parent), sister(Aunt, Parent).

ancestor(Ancestor, Person) :- child(Person, Ancestor).  % Базовый случай
ancestor(Ancestor, Person) :- child(AncestorsChild, Ancestor), ancestor(AncestorsChild, Person).    % Общий случай