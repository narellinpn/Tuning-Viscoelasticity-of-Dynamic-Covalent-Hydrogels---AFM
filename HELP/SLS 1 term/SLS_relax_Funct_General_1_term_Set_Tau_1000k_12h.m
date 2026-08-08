function y = SLS_relax_Funct_General_1_term_Set_Tau_1000k_12h(p,t)
%SLSCreepFunct Defines the relax function for the SLS model
% Used for ME 287
A = p(1);
B = p(2);
tau_epsilon = 716528.4308;

%Strain applied is 10%
strain = 0.1;

y = (A+B*exp(-t/(tau_epsilon)))*strain;
end