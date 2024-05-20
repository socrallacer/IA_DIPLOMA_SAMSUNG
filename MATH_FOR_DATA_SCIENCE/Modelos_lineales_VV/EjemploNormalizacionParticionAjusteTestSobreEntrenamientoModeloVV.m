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
%%%%
%%%%
%Particion de datos
%Vamos a separar datos Entrenamiento 80% y validación 20%
%Primero ordenamos datos por la variable a predecir (columna 4)

TodosDatosTHPNormalizadosOrdenados = sortrows(TodosDatosTHPNormalizados,4,'ascend')

%Cogemos uno de cada cinco datos para el conjunto de validación
DatosTHPNormalizadosValidacion= TodosDatosTHPNormalizadosOrdenados(5:5:end,:)

%Eliminamos esos datos del conjunto total para quedarnos con el conjunto de
%entrenamiento
TodosDatosTHPNormalizadosOrdenados(5:5:end,:) = []
DatosTHPNormalizadosEntrenamiento = TodosDatosTHPNormalizadosOrdenados;

%%%%%%
%%%%%%
%Entrenamos un primer modelos t = ah+bp+c 
%h--> columna 1
%p--> columna 3
%t--> columna 4

%Planteamos el sistema A1x = b que resolveremos por mínimos cuadrados
%Matriz de coeficientes del sistema de ecuaciones para el modelo 1
A1 = zeros(length(DatosTHPNormalizadosEntrenamiento),3);
A1(:,1) = DatosTHPNormalizadosEntrenamiento(:,1);
A1(:,2) = DatosTHPNormalizadosEntrenamiento(:,3);
A1(:,3) = ones(length(DatosTHPNormalizadosEntrenamiento),1);
b = DatosTHPNormalizadosEntrenamiento(:,4);
%determinamos los coeficientes por mínimos cuadrados
x = inv(A1'*A1)*A1'*b

%Calculamos error cuadrático de entrenamiento
%Valores predichos por el modelo para el conjunto de entrenamiento
bp = A1*x;

%Deshacer la normalización: multiplicamos por desviación típica y sumamos
%media
TemperaturasPredichasEntrenamiento1 = bp*DesviacionesTipicas(4)+Medias(4)
TemperaturasEntrenamiento1 = b*DesviacionesTipicas(4)+Medias(4)


%Mostramos predicciones y valores deseados
figure, plot(TemperaturasEntrenamiento1,TemperaturasPredichasEntrenamiento1,'.')

%Calculamos error cuadrático medio
ErrorEntrenamiento1Medio = ((TemperaturasEntrenamiento1-TemperaturasPredichasEntrenamiento1)'*(TemperaturasEntrenamiento1-TemperaturasPredichasEntrenamiento1))/length(TemperaturasPredichasEntrenamiento1)

%Calculamos el error de validación
%Matrices para los datos de validacion
A1v = zeros(length(DatosTHPNormalizadosValidacion),3);
A1v(:,1) = DatosTHPNormalizadosValidacion(:,1);
A1v(:,2) = DatosTHPNormalizadosValidacion(:,3);
A1v(:,3) = ones(length(DatosTHPNormalizadosValidacion),1);
bv = DatosTHPNormalizadosValidacion(:,4);

%Valores predichos para el conjunto de validación
bpv = A1v*x;

%Deshacer la normalización: multiplicamos por desviación típica y sumamos
%media
TemperaturasPredichasValidacion1 = bpv*DesviacionesTipicas(4)+Medias(4)
TemperaturasValidacion1 = bv*DesviacionesTipicas(4)+Medias(4)

%Mostramos predicciones y valores deseados
figure, plot(TemperaturasValidacion1,TemperaturasPredichasValidacion1,'.')

%Calculamos error cuadrático medio
ErrorValidacion1Medio = ((TemperaturasValidacion1-TemperaturasPredichasValidacion1)'*(TemperaturasValidacion1-TemperaturasPredichasValidacion1))/length(TemperaturasValidacion1)

%Hacemos test estadístico para determinar sobreentrenamiento
%Cociente entre errores cuadráticos medios
C = ErrorEntrenamiento1Medio/ErrorValidacion1Medio;

%Calculamos el percentil en la distribucion F
Percentil = fcdf(C,length(TemperaturasPredichasEntrenamiento1)-1,length(TemperaturasValidacion1)-1)

%Si este percentil es muy bajo, indica una probabilidad muy alta
%(100-Percentil) de que haya sobreentrenamiento.

%Tras ajustar el modelo t=a*sqrt(h)+bp + c nos da un error de validacion de
%5.92
ErrorValidacion2Medio = 5.92;
%Hacemos test de diferencia significativa entre los modelos
C = ErrorValidacion1Medio/ErrorValidacion2Medio;

%Calculamos el percentil en la distribucion F
Percentil = fcdf(C,length(TemperaturasValidacion1)-1,length(TemperaturasValidacion1)-1)
