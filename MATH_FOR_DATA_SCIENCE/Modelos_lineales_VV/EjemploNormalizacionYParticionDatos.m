%Ejemplo normalización de datos

TodosDatosTHP = [];
%Hemos creado la variable y antes de seguir pegamos los datos desde excel

%Calculamos medias y desviaciones
Medias = mean(TodosDatosTHP);
DesviacionesTipicas = std(TodosDatosTHP);

%Restamos medias
TodosDatosTHPNormalizados = TodosDatosTHP - Medias;

%Dividimos por desviaciones tipicas
TodosDatosTHPNormalizados = TodosDatosTHPNormalizados./DesviacionesTipicas;

%Comprobamos que tenemos ahora media 0 y desviación tipica 1
mean(TodosDatosTHPNormalizados)


std(TodosDatosTHPNormalizados)

%Podemos mostrar la nube de puntos para verificar que están en rangos
%similares
figure,plot(TodosDatosTHPNormalizados(:,1),TodosDatosTHPNormalizados(:,2),'.')

%Importante: El modelo que vamos a ajustar va a predecir la temperatura
%NORMALIZADA, por lo que para saber la temperatura real hay que multiplicar por la desviación tipica y sumarle la media después.

%Vamos a separar datos Entrenamiento 80% y validación 20%
%Primero ordenamos datos por la variable a predecir (columna 4)

TodosDatosTHPNormalizadosOrdenados = sortrows(TodosDatosTHPNormalizados,4,'ascend')

%Cogemos uno de cada cinco datos para el conjunto de validación
DatosTHPNormalizadosValidacion= TodosDatosTHPNormalizadosOrdenados(5:5:end,:)

%Eliminamos esos datos del conjunto total para quedarnos con el conjunto de
%entrenamiento
TodosDatosTHPNormalizadosOrdenados(5:5:end,:) = []
DatosTHPNormalizadosEntrenamiento = TodosDatosTHPNormalizadosOrdenados;
