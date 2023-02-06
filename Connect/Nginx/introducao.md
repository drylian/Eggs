# Obrigado por Usar o Nginx | Explorador de Arquivos 

* Este Egg foi criado usando um docker Alpine com entrypoint funcionando como bash Permitindo ser bem mais leve que outros sistemas.
* Só é possivel Usar Baixar conteúdo do site, para colocar arquivos no site entre em /Arquivos/ , pode criar pastas entre outros.

### Informações Basicas.

* A pasta /Arquivos pertence a onde vai ser armazenado o seus arquivos .
* A pasta /Arquivos/Publica é uma pasta sem restrições, qualquer um pode acessar ela mesmo com a conexão local ativada
* A Log_nginx.txt é mandada para a pasta /Arquivos por questoẽs de segurança
 

### Creditos para quem tornou isso possivel. 

* [Mohamnag](https://github.com/mohamnag/nginx-file-browser) O criador do Nginx File Browser.
* [Ashu11-A](https://github.com/Ashu11-A/) Ajudou na criação do docker Alpine e em algumas configurações do scripts.
* [Drylian](https://github.com/drylian) Criador do egg e do script.

### Leia-me
A pasta Status é o diretório onde será verificado se as instalações forão concluidas, Não delete a pasta.
Caso encontre algum problema em algum dos arquivos instalados.
Pode deletar eles aqui que o script irá reinstalar(Jamais delete a pasta Arquivos).

Nginx_instalador | Verificação do Nginx, Caso seja deletado, O Script vai Rebaixar o Nginx.

Explorer_instalador | Verificação do Explorer, Caso seja deletado, O Script vai Rebaixar o Explorer.

Pasta_instalador | Verificação do Pasta da Logs, Caso seja deletado, O Script vai Rebaixar o Logs.

Default.conf_instalado | Verificação da default no Nginx/conf.d, Caso seja deletado, O Script vai Rebaixar o default.conf.
