function u = commande_boost(iL, vC, Vin, mode)
% COMMANDE_BOOST
% Cette fonction de commande est utilisé dans le bloc Simulink Matlab
% Function
% Loi de commande non linéaire pour un convertisseur Boost.
%
% Entrées :
%   iL   : courant dans l'inductance (A)
%   vC   : tension de sortie (V)
%   Vin  : tension d'entrée instantanée (V)
%   mode : sélection de la loi de commande
%       1: commande à l'équilibre (u = u_eq)
%       2: Lyapunov : annulation complète de Vdot
%       3: Lyapunov : annulation des termes non stabilisants
%
% Sortie :
% u    : rapport cyclique


%% Paramètres de fonctionnement
R    = 10;    % résistance de charge (ohms)
Vref = 24;    % tension de sortie désirée (V)

%% 1) Point d'équilibre associé à Vref
u_eq  = 1 - Vin./Vref;      % duty à l'équilibre
iL_eq = Vref.^2./(R*Vin);   % courant inductif à l'équilibre
vC_eq = Vref;               % tension de sortie à l'équilibre

%% 2) Changement de Variables 
tilde_iL = iL - iL_eq;
tilde_vC = vC - vC_eq;

% Le terme non stable
w = vC_eq*tilde_iL - iL_eq*tilde_vC;

%% 3) Paramètres des lois de commande
alpha1 = 50;    % gain Lyapunov (commande 2) sur tilde_iL^2
alpha2 = 1.0;   % gain Lyapunov (commande 2) sur tilde_vC^2
k      = 0.5;   % gain Lyapunov (commande 3) sur w

%% 4) Sélection de la loi de commande
switch mode
    
    case 1
        % Mode 1 : duty simplement fixé à la valeur d'équilibre
        u = u_eq;
        
    case 2
        % Mode 2 : annulation complète de Vdot
        
        num = -alpha1*tilde_iL.^2 - (alpha2 - 1/R).*tilde_vC.^2;
        
        if abs(w) < 1e-6
            % si le dénominateur est trop petit, on évite la division
            u = u_eq;
        else
            u = u_eq + num./w;
        end
       
    case 3
        % Mode 3 : annulation des seuls termes non stabilisants
     
        u = u_eq - k*w;
        
    otherwise
        % mode non reconnu : on se rabat sur la commande à l'équilibre
        u = u_eq;
end

%% 5) Saturation du duty dans l'intervalle physique
u = max(min(u, 0.95), 0.05);

end