clc; clear all;

np=4;                                     % Horizont
ul=[0.2 60]'; uh=[0.4 90]';               % Obmedzenia
[Ac Bc]=obmedzeniavstupov(ul,uh,np)       % Test funkcie

