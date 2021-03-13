% Импортируйте данные из csv-файлов
spectra = importdata('spectra.csv');
starNames = importdata('star_names.csv');
lambdaStart = importdata('lambda_start.csv');
lambdaDelta = importdata('lambda_delta.csv');
% Определите константы
lambdaPr = 656.28; %нм
speedOfLight = 299792.458; %км/c
% Определите диапазон длин волн
Obs = size(spectra);
nObs = Obs(1);
mObs = Obs(2);
lambdaEnd = lambdaStart + (nObs - 1) * lambdaDelta;
lambda = (lambdaStart: lambdaDelta: lambdaEnd)';
% Рассчитайте скорости звезд относительно Земли
infomatrix = zeros(2, mObs)';
for i = 1:1:mObs
    s = spectra(: , i);
    [sHa, idx] = min(s);
    lambdaHa = lambda(idx);
    infomatrix(i, 1) = lambdaHa;
    infomatrix(i, 2) = idx;
end 
z = zeros(mObs, 1);
speed = zeros(mObs, 1);
for j = 1:1:mObs
    z(j) = (infomatrix(j, 1)/lambdaPr) - 1;
    if z(j)>0
    end
    speed(j) =z(j) * speedOfLight;
end
% Постройте график
fg1 = figure;

set(fg1, 'Visible', 'on');
movaway = []
for k = 1:1:mObs
    if z(k)>0
        plot(lambda, spectra(:, k), 'LineWidth', 3)
        movaway = [movaway; starNames(k)]
    else
        plot(lambda, spectra(:, k), '--' ,  'LineWidth', 1)
    end 
    hold on
end
legend(starNames)
xlabel('Длина волны, нм');
ylabel(['Интенсивность, эрг/см^2/с/', char(197)]);
title('Спектры звезд')
text(635, 3.25*10^(-13), 'Марков Константин, Б04-005')
grid on
hold off
% Сохраните график
saveas(fg1, 'spectraall.png');