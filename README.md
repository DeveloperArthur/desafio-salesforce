# Solução

## Metodologia utilizada
Para o processo de desenvolvimento desta solução foi utilizado Kanban com a ferramenta Trello e a essência do eXtreme programming:

- Foco em testes
- Foco em revisão de código
- Foco em design de software


## Ferramentas utilizadas no desenvolvimento

- VS Code para editar o código-fonte, dois plugins para auxiliar no desenvolvimento: Salesforce Extension Pack e ForceCode.

- SFDX para criar as classes, os componentes localmente, implantar os recursos criados localmente e baixar os recursos que foram criados no salesforce (Flow, Objetos customizados e etc).

- Git para versionador de código.

- Workbench para gerar e carregar o [package.xml da solução](https://drive.google.com/file/d/1W_4nJ2AsktNBG0o2V2j-gQQSDbCwyADi/view?usp=sharing).


## Endpoint para upsert Conta

Neste requisito utilizei o recurso do Salesforce chamado "RestResource", utilizado para expor uma classe Apex para a Web como um endpoint Rest.

Foram criadas 2 classes para esta solução, ContaController e ContaDto.

Em ContaController, no urlMapping atribui o valor ``"/Conta/"`` pois é uma boa prática do Rest deixar na URL o recurso que será utilizado naquele endpoint.

Como método HTTP utilizei ``Put`` pois documentações [da Salesforce](https://trailhead.salesforce.com/pt-BR/content/learn/modules/apex_integration_services/apex_integration_webservices) e [da comunidade](https://souforce.cloud/mergulhando-fundo-na-utilizacao-de-rest-api-do-salesforce/) nos recomendam a utilizar este método HTTP para ```upsert```.

Também utilizei o padrão DTO, criando a classe ContaDto para representar o JSON de resposta, utilizei este padrão pois não é recomendável devolver no JSON uma entidade de domínio (Account) e foi uma forma de definir meu contrato de saída.


## Endpoint para insert Pedido

Neste requisito segui com uma solução bem semelhante a de conta, também utilizei o recurso do Salesforce chamado "RestResource".

E foram criadas 2 classes para esta solução, PedidoController e PedidoDto.

Em PedidoController, no urlMapping atribui o valor ``"/Pedido/"`` pois no padrão Rest deixamos na URL o recurso que será utilizado no endpoint.

Como método HTTP utilizei ``Post`` pois é um envio de dados para salvar.

Nesta classe utilizei o design pattern Factory, utilizado para criar objetos dinamicamente, eu utilizei este pattern neste controller pois o objeto Pedido estava ocupando diversas linhas, por isso achei melhor isolar a criação do objeto em um método, apenas para questão de legibilidade.

Também utilizei o padrão DTO, criando a classe PedidoDto para representar o JSON de resposta, pois foi uma forma de definir meu contrato de saída e para não devolver o JSON de Order.

## Alternativas para ContaController e PedidoController

Como alternativa para essas duas soluções, tanto de Conta como de Pedido, um Aplicativo Conectado poderia ser criado e configurado, que é a API Rest nativa do Salesforce.

A vantagem é que ela já vem com todos os endpoints e JSON's de entrada e saída estabelecidos de todos os Objetos.

A desvantagem é que teríamos toda a API Rest configurada sem necessidade, por mais que os endpoints e JSON's já venham prontos, esta solução só precisa de dois endpoint's para conta e para pedido, estaríamos criando mais recurso do que necessário.

## Deletar Pedidos

Neste requisito utilizei dois recursos de assincronismo no Salesforce: Schedulable e Batchable.

A classe Schedulable é: JobDeletaPedidos.

É uma automação agendada que executa todos os dias.


Esta automação invoca o Batchable, chamado BatchDeletaPedidos.

Uma classe responsável por pegar os registros necessários e deletar em massa.

Como alternativa eu poderia ter utilizado Queueable ou Future Method mas Batchable é mais recomendado em casos onde podemos ter milhões de registros para processar pois ele pode processar até 50 milhões de registros.

Em BatchDeletaPedidos utilizei uma variável constante chamada ``NUMERO_DE_MESES`` para definir o número de meses em que a query deve buscar os registros, eu criei esta variável pois como diz no livro "Código Limpo" do Robert C. Martin, não devemos deixar "números mágicos" no código, o recomendado é criar uma variável constante, de preferência em maiúsculo, com um nome que descreve o propósito daquela variável.

## Incrementar valor no Pedido

Neste requisito criei um "Fluxo acionado por registro", chamado "Incrementa Valor do Pedido" pois a fonte de estimulo para a execução deveria ser uma inserção de um novo Pedido.

Como alternativa para esta solução, poderia ser criado uma Schedulable Apex, há uma desvantagem nesta abordagem pois eu estaria colocando complexidade desnecessária, visto que o requisito é simples e pode ser implementado utilizando Fluxo.

## Envio de email quando conta for criada ou editada

O componente está disponível na tela [Inicio](https://multiedro-1d-dev-ed.lightning.force.com/lightning/page/home) chamado "Crie e Atualize Contas"

Neste requisito eu utilizei, no Front-end o Aura Components para construir a interface gráfica de criar e atualizar conta, enviar email e mostrar um loading enquanto salva/atualiza e Aura Application para renderizar os componentes.

Abaixo está a Arquitetura de Componentes desta solução.
![Árvore de Componentes](https://drive.google.com/uc?export=view&id=1kiwuSLuFfxdWqksgL222s59gPnpTVUJ6)

Há um Aura Application chamado AppConta que renderiza o componente UpsertConta e o componente UpsertConta é pai do componente EnviaEmail, que é pai do componente Spinner, o que deixa a Arquitetura semelhante a uma cascata.

Há três componentes principais, um para criação/atualização da conta, outro apenas para o envio de email e outro para mostrar ou esconder o loading na página enquanto o backend processa o upsert, desta forma estamos utilizando um dos princípios SOLID, o princípio da responsabilidade única, pois cada componente tem sua responsabilidade, além disso temos uma vantagem, que é a reutilização de componentes, o que deixa o código mais legível e organizado.

Como alternativa para o Front-end, poderia ter utilizado Visualforce, mas utilizar SPA neste caso seria melhor, pois temos componentes renderizados dinamicamente, assim o carregamento fica mais rápido pois trata-se de apenas uma página.

No Back-end, foi necessário criar 3 classes (PaisController, PaisDto e EmailSalesforceClient) e editar a ContaController, para receber mais atributos e enviar email.

A classe PaisController é utilizada para buscar todos os países no momento em que o componente é renderizado, para o componente mostrar na lista todas as opções de países ao cadastrar uma conta.

A classe PaisDto foi necessária por uma questão de padrão, então, no Back-end, após a busca dos países, eles são convertidos em uma lista DTO, para evitar de devolver a entidade de domínio.

A classe EmailSalesforceClient é responsável por enviar o email, além disto, ela implementa a interface Queueable, eu utilizei esta interface pois é um processamento que pode ser enfileirado e executado de maneira assíncrona.

## Classes de Teste

As classes de teste foram criadas para garantir que as classes do Back-end estejam funcionando corretamente.

São estas:
- TestContaController
- TestDeletaPedidos
- TestEnvioDeEmail
- TestPedidosController
- TestPaisController
