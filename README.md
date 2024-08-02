Foi criado um Script para verificar e alterar o status do botão DND para que ele mude o compartamento do mesmo , este botão nativamente so ativa o modo não perturbe para o host porem no sistema ele ainda fica como disponivel.
o script.ps1 foi feito no PowerShell para detectar o clique no botão e chamar um atalho que tem que ser configurado manualmente esse atalho deve fazer uma chamada para os codigos *4801 e *4800 estes codigos ativam a função 
não pertube gerando assim uma pausa de recebimento de ligações no sistema.
O arquivo start.bat é um bat simples que executa o script, voce pode configurar para ele ser executado automaticamente colocando ele para ser chamado quando clicar no botão dnd é so alterar o seu arquivo microsipi.ini que fica no appdata
este arquivo ja configurado deixei disponivel para download tambem.

Deixei a pasta do programa portable zipada, é so descompactar e colocar no disco C: que ja sai funcionando 

Esta foi a unica forma que consegui resolver este problema, qualquer solução alternativa gostaria de saber espero ter ajudado!
