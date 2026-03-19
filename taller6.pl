% BASE DE CONOCIMIENTOS - RED SEMANTICA

% 1. RELACIONES DE JERARQUIA GENERAL (es_un)

% Jerarquia de personas
es_un(hombre_adulto, persona).
es_un(jugador_de_futbol, hombre_adulto).
es_un(defensa, jugador_de_futbol).
es_un(delantero, jugador_de_futbol).

% Jerarquia de Organizaciones Deportivas (Nueva Rama)
es_un(club_de_futbol, organizacion_deportiva).
es_un(equipo_profesional, club_de_futbol).


% 2. RELACIONES DE INSTANCIACION (instancia_de)

% Instancias de personas
instancia_de(adith, defensa).
instancia_de(miguel, delantero).

% Instancias de equipos profesionales (Nodos finales de la nueva rama)
instancia_de(millonarios, equipo_profesional).
instancia_de(nacional, equipo_profesional).


% 3. ASIGNACION DE CARACTERISTICAS (atributo)

% Atributos de la rama de personas
atributo(persona, pie_habil, derecho).
atributo(hombre_adulto, altura, 1.80).
atributo(jugador_de_futbol, altura, 1.85).
atributo(jugador_de_futbol, num_goles, 3).
atributo(jugador_de_futbol, patea, balon).
atributo(defensa, num_goles, 1).
atributo(delantero, num_goles, 5).

% Atributos de la rama de organizaciones deportivas
atributo(club_de_futbol, deporte_practicado, balompie).
atributo(equipo_profesional, necesita_estadio, si).
atributo(equipo_profesional, gana, 200000).

% Atributos de relacion (Conectan a las personas con sus equipos)
atributo(adith, equipo, millonarios).
atributo(miguel, equipo, nacional).


% REGLAS

% Regla de pertenencia: Permite escalar desde un individuo concreto 
% hacia las categorias generales a las que pertenece
pertenece(E, G) :- instancia_de(E, G).
pertenece(E, G) :- instancia_de(E, Inter), pertenece(Inter, G).

% Regla de pertenencia: Permite escalar entre subconjuntos
pertenece(E, G) :- es_un(E, G).
pertenece(E, G) :- es_un(E, Inter), pertenece(Inter, G).

% Regla de herencia: Busca el atributo solicitado. Si no lo encuentra 
% en el elemento consultado, asciende por la red buscando en las 
% categorías superiores. El operador de corte (!) detiene la búsqueda 
% al encontrar la primera coincidencia (para sobreescritura).
hereda(E, Atr, Val) :- atributo(E, Atr, Val).
hereda(E, Atr, Val) :- pertenece(E, G), atributo(G, Atr, Val), !.

% Regla de extension: Permite encadenar relaciones para descubrir 
% atributos indirectos
extiende(E, Atr, Val) :- atributo(E, Atr, Val).
extiende(E, Atr, Val) :- atributo(E, _, G), extiende(G, Atr, Val).
extiende(E, Atr, Val) :- atributo(E, _, G), hereda(G, Atr, Val).