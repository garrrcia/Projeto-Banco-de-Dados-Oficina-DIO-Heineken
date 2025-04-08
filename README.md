# Esquema Conceitual para Oficina Mecânica

## Objetivo:
Cria o esquema conceitual para o contexto de oficina com base na narrativa fornecida

## Narrativa:
Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica
Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas
Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.
A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra
O valor de cada peça também irá compor a OS
O cliente autoriza a execução dos serviços
A mesma equipe avalia e executa os serviços
Os mecânicos possuem código, nome, endereço e especialidade
Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.

## Entidades e Atributos

1. Cliente:
- ID_Cliente (PK): Identificador único do cliente.
- Nome: Nome completo do cliente.
- Endereco: Endereço do cliente.

2. Veículo:
- ID_Veiculo (PK): Identificador único do veículo.
- ID_Cliente (FK): Chave estrangeira referenciando a tabela Cliente.
- Modelo: Modelo do veículo.
- Marca: Marca do veículo.
- Ano: Ano de fabricação do veículo.
- Placa: Placa do veículo.

3. Equipe:
- ID_Equipe (PK): Identificador único da equipe de mecânicos.
- Nome_Equipe: Nome da equipe (opcional, para identificação).

4. Mecânico:
- ID_Mecanico (PK): Código único do mecânico.
- ID_Equipe (FK): Chave estrangeira referenciando a tabela Equipe.
- Nome: Nome completo do mecânico.
- Endereco: Endereço do mecânico.
- Especialidade: Área de especialização do mecânico.

5. Ordem_de_Servico (OS):
- Numero_OS (PK): Número único da ordem de serviço.
- ID_Veiculo (FK): Chave estrangeira referenciando a tabela Veículo.
- ID_Equipe (FK): Chave estrangeira referenciando a tabela Equipe.
- Data_Emissao: Data em que a OS foi emitida.
- Data_Entrega: Data prevista para a conclusão dos serviços.
- Valor_Total: Valor total da ordem de serviço.
- Status: Status atual da OS (Ex: Em Aberto, Em Execução, Concluída, Cancelada).

6. Servico:
- ID_Servico (PK): Identificador único do serviço.
- Descricao: Descrição detalhada do serviço.
- Valor_Mao_de_Obra: Valor da mão de obra para este serviço (consultado na tabela de referência).

7. Item_OS (Detalhe da OS):
- Numero_OS (FK): Chave estrangeira referenciando a tabela Ordem_de_Servico.
- ID_Servico (FK): Chave estrangeira referenciando a tabela Servico.
- Quantidade: Quantidade do serviço executado (geralmente 1 para serviços).
- Valor_Unitario: Valor unitário do serviço (copiado de Servico.Valor_Mao_de_Obra).
- Valor_Total_Item: Valor total deste item na OS (Quantidade * Valor_Unitario).
- (PK composta: Numero_OS, ID_Servico)

8. Peca:
- ID_Peca (PK): Identificador único da peça.
- Nome: Nome da peça.
- Descricao: Descrição da peça.
- Valor_Unitario: Valor unitário da peça.

9. Item_Peca_OS (Peças Utilizadas na OS):
- Numero_OS (FK): Chave estrangeira referenciando a tabela Ordem_de_Servico.
- ID_Peca (FK): Chave estrangeira referenciando a tabela Peca.
- Quantidade: Quantidade da peça utilizada.
- Valor_Unitario: Valor unitário da peça (copiado de Peca.Valor_Unitario).
- Valor_Total_Item: Valor total deste item de peça na OS (Quantidade * Valor_Unitario).
- (PK composta: Numero_OS, ID_Peca)

## Relacionamentos
- A seguir, são descritos os relacionamentos entre as entidades:
- Um Cliente pode ter muitos Veículos. (Um-para-Muitos)
- Um Veículo pertence a um Cliente. (Muitos-para-Um)
- Uma Equipe pode ter muitos Mecânicos. (Um-para-Muitos)
- Um Mecânico pertence a uma Equipe. (Muitos-para-Um)
- Uma Ordem_de_Servico é para um Veículo. (Um-para-Um)
- Um Veículo pode ter muitas Ordem_de_Servicos. (Um-para-Muitos)
- Uma Ordem_de_Servico é designada a uma Equipe. (Um-para-Um)
- Uma Equipe pode estar envolvida em muitas Ordem_de_Servicos. (Um-para-Muitos)
- Uma Ordem_de_Servico possui muitos Item_OS (serviços). (Um-para-Muitos)
- Um Servico pode estar em muitos Item_OS. (Muitos-para-Muitos, resolvido com a entidade Item_OS)
- Uma Ordem_de_Servico utiliza muitas Item_Peca_OS (peças). (Um-para-Muitos)
- Uma Peca pode ser utilizada em muitas Ordem_de_Servicos através de Item_Peca_OS. (Muitos-para-Muitos, resolvido com a entidade Item_Peca_OS)

  ![image](https://github.com/user-attachments/assets/1815e915-db59-4e70-b0fe-9cd638e62356)
