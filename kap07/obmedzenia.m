function [Ac b0 B0]=obmedzenia(p1,p2,p3,p4,p5,p6,p7)

switch nargin
case 3   % Iba obmedzenia na vstup   
    [Ac b0]     = obmedzeniavstupov(p1,p2,p3); % Obm. u
    B0=[];                                     
case 5  % Iba stavove obmedzenia
    [nx,nu]=size(p5);                        % Rozmery
    [Ac b0 B0] = obmedzeniastavov(p1,p2,p3,p4,p5); 
case 7  % Kombinacia obmedzeni
    [nx,nu]=size(p7);                       % Rozmery
    [Acu b0u]     = obmedzeniavstupov(p1,p2,p5);    
    [Acx b0x B0x] = obmedzeniastavov(p3,p4,p5,p6,p7); 
    Ac=[Acu;Acx];                           % Kombin. Ac
    b0=[b0u; b0x];                          % Kombin. b0
    B0=[zeros(2*p5*nu,nx); B0x];            % Kombin. B0
otherwise
    disp('Chyba na vstupe.');
end
