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
