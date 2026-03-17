% Base de Hechos
% Hombre adulto --es una--> Persona
es_un(hombre_adulto, persona).
es_un(futbolista, hombre_adulto).
es_un(defensa,futbolista).
es_un(delantero,futbolista).


% Adith --instancia de--> Defensa
instancia_de(carlos_mario_zuluaga, hombre_adulto).
instancia_de(radamel_falcao, delantero).
instancia_de(dairon_mosquera,defensa).
instancia_de(isabella_amado, defensa).
% Equipos de futbol
instancia_de(millonarios,equipo).
instancia_de(union_magdalena,equipo).
instancia_de(atletico_cafeteros,equipo).
instancia_de(millonarios,equipo).
instancia_de(manuel,hombre_adulto).
% Ligas de futbol
instancia(categoria_a,liga).
instancia(categoria_b,liga).
instancia(femenina,liga).

% Persona --pie habil--> Derecho
atributo(persona,pie_habil,derecho).
atributo(hombre_adulto,altura,1.80).
atributo(futbolista,altura,1.85).
atributo(futbolista,num_goles,3).
atributo(futbolista,patea,balon).
atributo(defensa,num_goles,1).
% Asignar equipos a futbolistas
atributo(radamel_falcao,equipo,millonarios).
atributo(dairon_mosquera,equipo,union_magdalena).
atributo(isabella_amado,equipo,millonarios).
% Asignar ligas a equipos
atributo(millonarios,liga,categoria_a).
atributo(millonarios,liga,femenina).
atributo(union_magdalena,liga,categoria_b).
atributo(categoria_a,presidente,carlos_mario_zuluaga).

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

% Tiene Atributo, buscar si alguno tiene ese valor
extiende_atr(E,Atr,Val) :- atributo(E, Atr, Val).
extiende_atr(E,Atr,Val) :- atributo(E, _, G), extiende_atr(G,Atr,Val).

% TODO: agregar caso ampliado con equipos