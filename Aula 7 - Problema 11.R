#---------------------------------------------------------------------------
# Modelando o problema
#---------------------------------------------------------------------------

# Funcao objetivo
# MinC = 2.25Xeo + 2.25Xe1 + 2.25Xe2 + 2.25Xe3
#                  33.5Xd1 + 33.5Xd2 + 33.5Xd3

# Variáveis
#                         Xd1             <= 20000
#                               Xd2       <= 20000
#                                     Xd3 <= 20000
# Xe0                                      = 30
#                   Xe3                    = 0
# Xe0 - Xe1             + Xd1              = 17500
#       Xe1 - Xe2             + Xd2        = 21300
#             Xe2 - Xe3             + Xd3  = 21000

#-----------------------------------------------------------------------------
# Implemenatndo o problema
#----------------------------------------------------------------------------

library(lpSolve)

funcao_objetivo = c(2.25, 2.25, 2.25, 2.25,
                          33.5, 33.5, 33.5)

  restricoes = matrix(c(0, 0, 0, 0, 1, 0, 0,
                        0, 0, 0, 0, 0, 1, 0,
                        0, 0, 0, 0, 0, 0, 1,
                        1, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 1, 0, 0, 0,
                        1,-1, 0, 0, 1, 0, 0,
                        0, 1,-1, 0, 0, 1, 0,
                        0, 0, 1,-1, 0, 0, 1), ncol = 7, byrow = T)

  restricoes_dir = c("<=",
                     "<=",
                     "<=",
                     "=",
                     "=",
                     "=",
                     "=",
                     "=")  

  restricoes_rhs = c(20000,
                     20000,
                     20000,
                     30,
                     0,
                     17500,
                     21300,
                     21000)  

  res_modelo = lp("min",
                  funcao_objetivo,
                  restricoes,
                  restricoes_dir,
                  restricoes_rhs,
                  all.int = T,
                  compute.sens = T)  
  
#-------------------------------------------------------------------------
# Resultados
#-------------------------------------------------------------------------
  
res_modelo                   # custo em R$
res_modelo$solution          # qtd materiais produzidos e estocados no mes
res_modelo$sens.coef.from    # valores min do parametro
res_modelo$sens.coef.to      # valores max do parametro
res_modelo$duals             # preço sombra das restricoes
res_modelo$duals.from        # preco sombra min das restricoes
res_modelo$duals.to          # preso sombra max das restricoes
  