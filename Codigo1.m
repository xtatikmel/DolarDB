%% Carga de datos y generación de archivos
clc
clear all
datetime
%archivo = 'HistoricoDolar.xlsx';
%historico = xlsread(archivo,-1);
database = xlsread ('DB Datos.xlsx');
dolar = xlsread ('DB Datos.xlsx',-1);

[num,txt,raw] = xlsread('HistoricoDolar.xlsx');
dolarhisto = readtable('HistoricoDolar.xlsx');
filename = 'DB Datos.xlsx';
sheet = 'Hoja1';

% Lee los datos del archivo
[nume, txt, raw] = xlsread(filename, sheet);

% Extrae las fechas de la primera y última fila
primera_fecha = raw{2, 1};
ultima_fecha = raw{end, 1}; 
% Extrae los precios de la primera y última fila
primer_valor = raw{2, 2}; 
ultimo_valor = raw{end, 2}; 
% Muestra las fechas en la ventana de comandos
disp(['La primera fecha tomada fue: ', primera_fecha]);
fprintf('(3)Y el precio del dolar era:  %.2f\n', primer_valor);
disp(['La última fecha tomada fue: ', ultima_fecha]);
fprintf('(3)Y el precio del dolar era:  %.2f\n', ultimo_valor);
%----------------------------------------------------------------
%% Análisis Estadístico
%%% (1) Calcular el promedio de los datos, y restar el valor obtenido al
% conjunto de datos.
    promedio = mean(database);
    %disp(promedio);
    cambio_diario = diff(num)./num(1:end-1);
    promedio_cambio = mean(cambio_diario);
fprintf('(1) El promedio del dólar es: %.2f\n', promedio);
fprintf('(1) El cambio promedio del dólar es: %.8f\n', promedio_cambio);
xlswrite('DB Datos.xlsx',{'Promedio';'cambio_diario';'promedio_cambio'},'Estadísticas','B2')
xlswrite('DB Datos.xlsx',[promedio;cambio_diario;promedio_cambio],'Estadísticas','C2')

%%% (2)Identificar el valor máximo y mínimo de la función
    mx = max(database);
fprintf('(2) El valor maximo del dólar es: %.2f\n', mx);
    mn = min(database);
fprintf('(2) El valor minimo del dólar es: %.2f\n', mn);
xlswrite('DB Datos.xlsx',{'valor maximo';'valor minimo'},'Estadísticas','B5')
xlswrite('DB Datos.xlsx',[mx;mn],'Estadísticas','C5')
%----------------------------------------------------------------

%%% (3) Calcular el rango,
    rango = range(database);
fprintf('(3) El valor rango del dólar es: %.2f\n', rango);

% la media (aritmética, geométrica y armónica),
    media = mean(dolar);
    media_aritmetica = mean(dolar);
    media_geometrica = geomean(dolar);
    media_armonica = harmmean(dolar);
fprintf('(3) La Media aritmética del dólar es: %.2f\n', media_aritmetica);
fprintf('(3) La Media geométrica del dólar es: %.2f\n', media_geometrica);
fprintf('(3) La Media armónica del dólar es: %.2f\n', media_armonica);
% mediana, 
    mediana = median(dolar);
fprintf('(3) La Mediana del dólar es: %.2f\n', mediana);
% moda, 
    moda = mode(dolar);
fprintf('(3) La Moda del dólar es: %.2f\n', moda);
% desviación (estándar o típica
    desviacion_estandar = std(dolar);
fprintf('(3) La desviación típica del dólar es: %.2f\n', desviacion_estandar);
% desviación media), 
    desviacion_media = mean(abs(dolar - media_aritmetica));
fprintf('(3) La desviación media del dólar es: %.2f\n', desviacion_media);    
% esperanza, 
    esperanza = promedio;
fprintf('(3) La esperanza del dólar es: %.2f\n', esperanza);
% varianza,
    varianza = var(dolar);
fprintf('(3) La varianza del dólar es: %.2f\n', varianza);
    desviaciones = dolar - media;
    varianza2 = sum(desviaciones .^ 2) / (length(dolar) - 1);
fprintf('(3) La varianza 2 del dólar es: %.2f\n', varianza2);
% covarianza,
    covarianza = cov(dolar);
fprintf('(3) La Covarianza del dólar es: %.2f\n', covarianza);
% coeficiente de variación (𝐶𝑉 =𝜎𝑥|𝑋̅|,𝑑𝑒𝑠𝑣𝑖𝑎𝑐𝑖ó𝑛 𝑒𝑠𝑡á𝑛𝑑𝑎𝑟 𝑦 𝑋̅ 𝑚𝑒𝑑𝑖𝑎 𝑎𝑟𝑖𝑡𝑚é𝑡𝑖𝑐𝑎),
    coeficiente_variacion = desviacion_estandar / media;
fprintf('(3) La Coeficiente de variación del dólar es: %.4f\n', coeficiente_variacion);
% coeficiente de variación de Pearson (𝑟 = 𝑆𝑥 |𝑥̅|, 𝑠𝑖𝑒𝑛𝑑𝑜 𝑆𝑥 𝑙𝑎 𝑑𝑒𝑠𝑣𝑖𝑎𝑐𝑖ó𝑛 
% 𝑡í𝑝𝑖𝑐𝑎 𝑦 𝑥̅ 𝑙𝑎 𝑚𝑒𝑑𝑖𝑎 𝑑𝑒𝑙 𝑐𝑜𝑛𝑗𝑢𝑛𝑡𝑜 𝑑𝑒 𝑜𝑏𝑠𝑒𝑟𝑣𝑎𝑑𝑜𝑟𝑒𝑠), 
    coeficiente_pearson = (desviacion_estandar/media_aritmetica)*100;
fprintf('(3) La Coeficiente de variación de Pearson del dólar es: %.2f\n', coeficiente_pearson);
% coeficiente de apertura (𝐶𝐴𝑃 = 𝑚á𝑥{𝑥𝑖} 𝑚í𝑛{𝑥𝑖}), 

% coeficiente de asimetría (𝐴𝑆 = 𝑋̅− 𝑀0/𝑆, 𝑋̅ 𝑒𝑠 𝑙𝑎 𝑚𝑒𝑑𝑖𝑎 𝑎𝑟𝑖𝑡𝑚é𝑡𝑖𝑐𝑎, 
% 𝑀0 𝑒𝑠 𝑙𝑎 𝑚𝑜𝑑𝑎 𝑦 𝑆 𝑒𝑠 𝑙𝑎 𝑑𝑒𝑠𝑣𝑖𝑎𝑐𝑖ó𝑛 𝑒𝑠𝑡á𝑛𝑑𝑎𝑟), 
coef_asimetria = skewness(dolar);
%disp(coef_asimetria);
coefi_asimetria = ((media_aritmetica-moda)/desviacion_estandar);
fprintf('(3) El Coeficiente de asimetria arrojado es: %.2f\n', coef_asimetria);
fprintf('(3) El Coeficiente de asimetria calculado es: %.2f\n', coefi_asimetria);
% kurtosis, 
k = kurtosis(dolar);
fprintf('(3) La kurtosis es: %.2f\n', k);
%kurtosis poblacional
ku = kurtosis(dolar, 0);
fprintf('(3) La kurtosis poblacional es: %.2f\n', ku);
% la convolución y la correlación. 

%También deben calcular el número de índice
indice = (ultimo_valor - primer_valor) / primer_valor * 100;
fprintf('(3) El número de índice es: %.2f\n', indice);
% la tasa

% el coeficiente de Gini

% El coeficiente de correlación lineal
xlswrite('DB Datos.xlsx',{'Rango';'Media Aritmética';'Media Geometrica'; ...
    'Media Armonica';'La Mediana';'Moda'},'Estadísticas','B7')
xlswrite('DB Datos.xlsx',[rango;media_aritmetica;media_geometrica; ...
    media_armonica;mediana;moda],'Estadísticas','C7')
%----------------------------------------------------------------
%% Lugar de Raíces (Cruces x Cero), Máximos Relativos y Mínimos Relativos
% Utilizar la instrucción "find" o el "Teorema de Boltzman" 
% 𝑓(𝑎) ∗ 𝑓(𝑏) < 0, 𝑐𝑜𝑛 𝑎, 𝑏 𝑣𝑎𝑙𝑜𝑟𝑒𝑠
% 𝑐𝑜𝑛𝑠𝑒𝑐𝑢𝑡𝑖𝑣𝑜𝑠 𝑑𝑒 𝑙𝑎 𝑓𝑢𝑛𝑐𝑖ó𝑛 para buscar los ceros del grupo de datos. 
% Teniendo en cuenta que el cruce por cero se puede obtener interpolando 
% linealmente los dos valores o eligiendo el más cercano al cero
%Identificar los máximos relativos con coordenadas 
% (𝑏, 𝑓(𝑏)) 𝑓(𝑎) < 𝑓(𝑏) < 𝑓(𝑐), 𝑐𝑜𝑛 𝑎, 𝑏, 𝑐 𝑣𝑎𝑙𝑜𝑟𝑒𝑠 𝑐𝑜𝑛𝑠𝑒𝑐𝑢𝑡𝑖𝑣𝑜𝑠 𝑑𝑒 𝑙𝑎 𝑓𝑢𝑛𝑐𝑖ó𝑛
%Identificar los mínimos relativos con coordenadas 
% (𝑏, 𝑓(𝑏))𝑓(𝑎) > 𝑓(𝑏) > 𝑓(𝑐), 𝑐𝑜𝑛 𝑎, 𝑏, 𝑐 𝑣𝑎𝑙𝑜𝑟𝑒𝑠 𝑐𝑜𝑛𝑠𝑒𝑐𝑢𝑡𝑖𝑣𝑜𝑠 𝑑𝑒 𝑙𝑎 𝑓𝑢𝑛𝑐𝑖ó𝑛
%----------------------------------------------------------------
%% Gráfica de Datos
%Graficar el conjunto de datos con ayuda del comando subplot, plot y fplot 
% (Ver ejemplo a continuación)
%hold on;
%plot(Registro,%x’);
%fplot(%x+3’,[1 6]);
%hold off;
%o Graficar los datos reales y los datos modificados con ayuda de la 
% instrucción subplot en un mismo objeto figure o Graficar los cruces x 
% cero, los mínimos relativos y los máximos relativos utilizando marcas 
% y etiquetas (legend)
hold on;
[data,header] = xlsread('DB Datos.xlsx',1);
fecha = datetime(header(2:end,1),'InputFormat','dd/MM/yyyy');
plot(fecha,database)
datetick('x','yyyy');
xlabel('Tiempo (Años)');
ylabel('Cambio Dolar (Pesos)');
title('Variación del dolar con el tiempo');
hold off;
%----------------------------------------------------------------
load DolarDB.mat;
save DolarDB;

