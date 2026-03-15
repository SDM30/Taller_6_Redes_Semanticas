% Base de Hechos
% Hombre adulto --es una--> Persona
es_un(hombre_adulto, persona).
es_un(jugador_de_futbol, hombre_adulto).
es_un(defensa, jugador_de_futbol).
es_un(delantero, jugador_de_futbol).

% Adith --instancia de--> Defensa (Cambiado de Falcao/Isabella a Adith)
instancia_de(adith, defensa).
% Miguel --instancia de--> Delantero (Cambiado de Mosquera a Miguel)
instancia_de(miguel, delantero).

% Persona --pie habil--> Derecho
atributo(persona, pie_habil, derecho).
atributo(hombre_adulto, altura, 1.80).
atributo(jugador_de_futbol, altura, 1.85).
atributo(jugador_de_futbol, num_goles, 3).
atributo(jugador_de_futbol, patea, balon).
atributo(defensa, num_goles, 1).
atributo(delantero, num_goles, 5).

% Asignar equipos a futbolistas
atributo(adith, equipo, millonarios).
atributo(miguel, equipo, nacional).

% Reglas
% Pertenece: de instancia especifica a conjunto general
pertenece(E, G) :- instancia_de(E, G).
pertenece(E, G) :- instancia_de(E, Inter), pertenece(Inter, G).

% Pertenece: de subconjunto especifico a conjunto general
pertenece(E, G) :- es_un(E, G).
pertenece(E, G) :- es_un(E, Inter), pertenece(Inter, G).

% Busca el atributo del conjunto que esta inmediatemente sobre el
% ej: Adith toma 1.85 no 1.80
hereda(E, Atr, Val) :- atributo(E, Atr, Val).
hereda(E, Atr, Val) :- pertenece(E, G), atributo(G, Atr, Val), !.
