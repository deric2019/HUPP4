% Uppgift f
clc
clear all
clf

lambda_noll = 650e-9;
k_noll = 2*pi/lambda_noll;
ljusar = 9.461e15;
L =70*ljusar;
D_sol = 1.3927e9;


N = 200; % Antalet observationspunkter (punkter längs u-axeln där fältet beräknas)
D_star = 45*D_sol; % D_star: Stjärnans diameter [m]
separation = D_star/30;  % avstånd mellan punktkällorna på stjärnan [m]
%             kan lämpligen anges som bråkdel av D_star
%             t.ex. separation=D_star/30

[x,y,M] = xy_source(N,D_star,separation);
u_vekt = linspace(0,20,N);
u = repmat(u_vekt,M,1);

r = -x.*u/L;
sum_instant = 0;
sum_instant_I = 0;
sum_korr_I = 0;
t_slut = 2000;

for i = 1:t_slut
    fas_vekt = rand(M,1)*2*pi;
    fas = repmat(fas_vekt,1,N);
    E_k_obs = exp (1i*(fas+k_noll*r));
    E_obs = sum(E_k_obs);
    I_obs_inst = abs(E_obs).^2;
    instantan_produkt = E_obs(1) * conj(E_obs) ;
    sum_instant = sum_instant+ instantan_produkt ;
    sum_instant_I = sum_instant_I + I_obs_inst ;
    sum_korr_I = sum_korr_I + I_obs_inst(1)*I_obs_inst;
end


plot(u_vekt,sum_korr_I) ;
xlabel('u−axeln')
ylabel('<I ( 0 ) ∗ I (u)>')









