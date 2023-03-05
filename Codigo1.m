%% Carga de datos y generación de archivos
clc
clear all
%archivo = 'HistoricoDolar.xlsx';
%historico = xlsread(archivo,-1);
    database = xlsread ('DB Datos.xlsx');
    dolar = xlsread ('DB Datos.xlsx',-1);
    [num,txt,raw] = xlsread('HistoricoDolar.xlsx');
    save;
    dolarhisto = readtable('HistoricoDolar.xlsx');
%[Fecha,dolar] = xlsread('DB Datos.xlsx')
%----------------------------------------------------------------
%% Análisis Estadístico
% (1) Calcular el promedio de los datos, y restar el valor obtenido al
% conjunto de datos.
    promedio = mean(database);
    %disp(promedio);
    cambio_diario = diff(num)./num(1:end-1);
    promedio_cambio = mean(cambio_diario);
fprintf('(1) El promedio del dólar es: %.2f\n', promedio);
fprintf('(1) El cambio promedio del dólar es: %.8f\n', promedio_cambio);
% (2)Identificar el valor máximo y mínimo de la función
    mx = max(database);
fprintf('(2) El valor maximo del dólar es: %.2f\n', mx);
    mn = min(database);
fprintf('(2) El valor minimo del dólar es: %.2f\n', mn);
%xlswrite('DB Datos.xlsx',{'Promedio';'Mediana'},'Estadísticas','B2')
%xlswrite('DB Datos.xlsx',[meanDatos;medianDatos],'Estadísticas','C2')
%----------------------------------------------------------------
% (3) Calcular el rango,
    rango = range(database);
fprintf('(3) El valor rango del dólar es: %.2f\n', rango);
% la media (aritmética, geométrica y armónica),
    media_aritmetica = mean(dolar);
    media_geometrica = geomean(dolar);
    media_armonica = harmmean(dolar);
fprintf('(3) La Media aritmética del dólar es: %.2f\n', media_aritmetica);
fprintf('(3) La Media geométrica del dólar es: %.2f\n', media_geometrica);
fprintf('(3) La Media armónica del dólar es: %.2f\n', media_armonica);
% mediana, 
    mediana = median(dolar);
fprintf('(3) La Mediana del dólar es: %.2f\n', mediana);
% moda, desviación (estándar o típica y media), esperanza, 
% varianza, covarianza, coeficiente de variación (𝐶𝑉 =𝜎𝑥|𝑋̅|,𝜎𝑥 𝑑𝑒𝑠𝑣𝑖𝑎𝑐𝑖ó𝑛 
% 𝑒𝑠𝑡á𝑛𝑑𝑎𝑟 𝑦 𝑋̅ 𝑚𝑒𝑑𝑖𝑎 𝑎𝑟𝑖𝑡𝑚é𝑡𝑖𝑐𝑎), coeficiente de
% variación de Pearson (𝑟 = 𝑆𝑥 |𝑥̅|, 𝑠𝑖𝑒𝑛𝑑𝑜 𝑆𝑥 𝑙𝑎 𝑑𝑒𝑠𝑣𝑖𝑎𝑐𝑖ó𝑛 𝑡í𝑝𝑖𝑐𝑎 𝑦 𝑥̅ 𝑙𝑎 𝑚𝑒𝑑𝑖𝑎 
% 𝑑𝑒𝑙 𝑐𝑜𝑛𝑗𝑢𝑛𝑡𝑜 𝑑𝑒 𝑜𝑏𝑠𝑒𝑟𝑣𝑎𝑑𝑜𝑟𝑒𝑠), coeficiente de apertura 
% (𝐶𝐴𝑃 = 𝑚á𝑥{𝑥𝑖} 𝑚í𝑛{𝑥𝑖}), coeficiente de asimetría (𝐴𝑆 = 𝑋̅− 𝑀0 𝑆, 𝑋̅ 𝑒𝑠 𝑙𝑎 
% 𝑚𝑒𝑑𝑖𝑎 𝑎𝑟𝑖𝑡𝑚é𝑡𝑖𝑐𝑎, 𝑀0 𝑒𝑠 𝑙𝑎 𝑚𝑜𝑑𝑎 𝑦 𝑆 𝑒𝑠 𝑙𝑎 𝑑𝑒𝑠𝑣𝑖𝑎𝑐𝑖ó𝑛 𝑒𝑠𝑡á𝑛𝑑𝑎𝑟), kurtosis, 
% la convolución y la correlación. También deben calcular el número de 
% índice, la tasa, el coeficiente de Gini y el coeficiente de correlación 
% lineal.

%----------------------------------------------------------------
%% Lugar de Raíces (Cruces x Cero), Máximos Relativos y Mínimos Relativos
%----------------------------------------------------------------
%% Gráfica de Datos
%plot(database)
%XDates = [datetime("2012-01-01") datetime("2021-02-28")];
%YNumsForXDates = (num);
%plot(XDates,YNumsForXDates)
%----------------------------------------------------------------