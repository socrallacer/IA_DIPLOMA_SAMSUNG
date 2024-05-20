%Ajuste modelos lineales

%Definimos matriz de coeficientes para el modelo y=ax+b con los datos de
%entrenamiento de EjemploAjusteCurvas.xls
A = [0.0115 1; 0.012 1; 0.013 1; 0.026 1; 0.034 1; 0.04 1; 0.084 1; 0.092 1]

%Términos independientes de entrenamiento
b = [50.5; 50.2; 48.5; 35; 38; 28; 15; 20.5;]

%Resolvemos Ax=b por mínimos cuadrados
x = inv(A'*A)*A'*b

%Calculamos las predicciones dadas por el modelo para los datos de
%entrenamiento
bp = A*x

%Calculamos el error cometido en lso datos de entrenamiento (suma de
%errores cuadráticos)
ErrorEntrenamiento = (b-bp)'*(b-bp)

%Vamos a ver el error cometido en los datos de validación
%Definimos matriz de coeficientes para los datos de validación
Av = [0.012 1; 0.012 1; 0.0135 1; 0.032 1; 0.038 1; 0.041 1; 0.086 1; 0.098 1]

%Términos independientes de los datos de validación
bv = [49; 44.5; 47.5; 34.5; 31.5; 38.5; 29.5; 17]

%Valores predichos para los datos de validación. IMPORTANTE: usamos los
%mismos coeficientes x que antes, no se vuelven a calcular.
bvp = Av*x

%Error cometido
ErrorValidacion = (bv-bvp)'*(bv-bvp)

%Test de sobreentrenamiento
C = ErrorEntrenamiento/ErrorValidacion;

%Calculamos percentil.
P = fcdf(C,length(b),length(bv))*100

['La probabilidad de tener sobreentrenamiento es ' num2str(100-P)]



