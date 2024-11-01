clc;
clear;
close all;

E0 = 0;
m0 = 0;
h0 = 0.;
c0 = 0;
n0 = 0;
a0 = 0;
hA0 = 0;

C = 10^-3;
g_Na = 40;
g_Ca = 2;
g_K = 12;
g_A = 36 ;
E_Na = 35;
E_K = -75;
E_Ca = 30;
I = 1;
ICa = 10^-2;


interval = 20;
dt = 0.0001;
points = interval/dt;

t = zeros (points+1,1);
E = zeros (points+1,1);
m = zeros (points+1,1);
h = zeros (points+1,1);
c = zeros (points+1,1);
n = zeros (points+1,1);
a = zeros (points+1,1);
hA = zeros (points+1,1);
Ca_i = zeros (points+1, 1);
g_KCa = zeros (points+1, 1);

a_m = zeros (points, 1);
b_m = zeros (points, 1);

a_h = zeros (points, 1);
b_h = zeros (points, 1);
a_c = zeros (points, 1);
b_c = zeros (points, 1);
a_n = zeros (points, 1);
b_n = zeros (points, 1);
a_a = zeros (points, 1);
b_a = zeros (points, 1);
a_hA = zeros (points, 1);
b_hA = zeros (points, 1);



t(1) = 0;
E(1) = 0;
m(1) = 0;
h(1) = 0;
c(1) = 0;
n(1) = 0;
a(1) = 0;
hA(1) = 0;
Ca_i(1) = 0;
g_KCa(1) = 0.05 * (Ca_i(1) / 10^-6)^2/(1+(Ca_i(1)/10^-6)^2);


for i=1 : points
    
    
    Ca_i(i+1) = Ca_i(i) + dt* (-0.000015 * ICa - 0.02 * (Ca_i(i)-0.0001));
    g_KCa(i+1) = 0.05 * (Ca_i(i+1) / 10^-6)^2/(1+(Ca_i(i+1)/10^-6)^2);
    
    
    a_m(i,1) = (-0.6*(E(i)+30))/(exp(-0.1*(E(i)+30))-1);
    b_m(i,1) = 20*exp(-(E(i)+55)/18);
    a_h(i,1) = 0.4 * exp(-(E(i)+50)/20);
    b_h(i,1) = 6 / (exp(-0.1*(E(i)+20))+1);
    a_c(i,1) = (-0.3 * (E(i)+13))/(exp(-0.1 * (E(i)+13))-1);
    b_c(i,1) = 10 * exp(-(E(i)+38)/18);
    a_n(i,1) = (-0.02 * (E(i)+40))/(exp(-0.1 * (E(i)+40))-1);
    b_n(i,1) = 0.4 * exp(-(E(i)+50)/80);
    a_a(i,1) = (-0.006 * (E(i)+90))/(exp(-0.1 * (E(i)+90))-1);
    b_a(i,1) = 0.1 * exp(-(E(i)+30)/10);
    a_hA(i,1) = 0.04 * exp(-(E(i)+70)/20);
    b_hA(i,1) = 0.6 / (exp(-0.1*(E(i)+40))+1);

    
    
    t(i+1) = t(i) + dt;
    E(i+1) = E(i) + dt .* (-g_Na*m(i)^3*h(i)*(E(i)-E_Na) - g_Ca*c(i)^3*(E(i)-E_Ca) - g_K*n(i)^4*(E(i)-E_K) - g_A*a(i)^3*hA(i)*(E(i)-E_K) - g_KCa(i)*(E(i)-E_K) + I)/C;
    m(i+1) = m(i) + dt .* (a_m(i) - (a_m(i) + b_m(i)) * m(i));
    h(i+1) = h(i) + dt .* (a_h(i) - (a_h(i) + b_h(i)) * h(i));
    c(i+1) = c(i) + dt .* (a_c(i) - (a_c(i) + b_c(i)) * c(i));
    n(i+1) = n(i) + dt .* (a_n(i) - (a_n(i) + b_n(i)) * n(i));
    a(i+1) = a(i) + dt .* (a_a(i) - (a_a(i) + b_a(i)) * a(i));
    hA(i+1) = hA(i) + dt .* (a_hA(i) - (a_hA(i) + b_hA(i)) * hA(i));
    
end
figure
    plot(t,E);
    xlabel('Time');
    ylabel('Membrane Potential');
    title('Voltage time series');



