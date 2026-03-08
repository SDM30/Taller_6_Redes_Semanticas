%Base de Hechos
% Hombre adulto --es una--> Persona
es_un(hombre_adulto, persona).
es_un(futbolista, hombre_adulto).
es_un(defensa,futbolista).
es_un(delantero,futbolista).


% Adith --instancia de--> Defensa
instancia_de(adith, defensa).
instancia_de(miguel,delantero).

% Persona --pie habil--> Derecho
atributo(persona, pie_habil, derecho).
atributo(hombre_adulto, altura, 1.80).
atributo(futbolista, altura, 1.85).
atributo(futbolista, num_goles, 3).
atributo(futbolista, patea, balon).
atributo(defensa,num_goles,1).


% Reglas
% Pertenece: de instancia especifica a conjunto general
pertenece(E,G) :- instancia_de(E,G).
pertenece(E,G) :- instancia_de(E,Inter), pertenece(Inter,G).

% Pertenece: de subconjunto especifico a conjunto general
pertenece(E,G) :- es_un(E,G).
pertenece(E,G) :- es_un(E,Inter), pertenece(Inter,G).

% Busca el atributo del conjunto que esta inmediatemente sobre el
% ej: Adith toma 1.85 no 1.80
hereda(E, Atr, Val) :- atributo(E, Atr, Val).
hereda(E, Atr, Val) :- pertenece(E,G) ,atributo(G, Atr, Val), !.
