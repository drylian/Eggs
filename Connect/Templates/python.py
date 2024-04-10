import socket
import sys

def get_port(args):
    """
    Extrai a porta do script Python.

    Args:
        args: Argumentos da linha de comando (sys.argv).

    Returns:
        A porta como um número inteiro.
    """
    for i in range(len(args)):
        if args[i] == "-port":
            return int(args[i+1])
    return None

args = sys.argv
porta = get_port(args)
if porta is None:
    print("Porta não especificada. Utilize o argumento -port seguido do número da porta.")
    sys.exit(1)

servidor = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
servidor.bind(('', porta))
servidor.listen()

while True:
    conexao, cliente = servidor.accept()
    requisicao = conexao.recv(1024)
    requisicao_str = requisicao.decode('utf-8')

    # Construindo a resposta HTTP
    resposta_http = "HTTP/1.1 200 OK\r\n"
    resposta_http += "Content-Type: text/html; charset=utf-8\r\n"
    resposta_http += "\r\n"  # Fim dos cabeçalhos, início do corpo da resposta
    resposta_http += '<!DOCTYPE html>'\
                    '<html lang="en">'\
                    '<head>'\
                        '<meta charset="UTF-8">'\
                        '<meta name="viewport" content="width=device-width, initial-scale=1.0">'\
                        '<title>Aplicação Python</title>'\
                        '<link rel="shortcut icon" href="https://cdn.discordapp.com/attachments/1005181663027929210/1227724484253978676/cus1jiv0pqvrv93523ref26h09.png?ex=66297287&is=6616fd87&hm=812313cd34a1d5945429a7417d184083927fd876b89495927d0061cb34fd0733&" type="image/png" style="border-radius: 50px;">'\
                        '<link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">'\
                    '</head>'\
                    '<body class="bg-gray-100">'\
                        '<div class="flex justify-center items-center flex-col mx-auto px-4 py-8">'\
                        '<img class="w-36 h-36" src="https://cdn.discordapp.com/attachments/1005181663027929210/1227724484253978676/cus1jiv0pqvrv93523ref26h09.png?ex=66297287&is=6616fd87&hm=812313cd34a1d5945429a7417d184083927fd876b89495927d0061cb34fd0733&"/>'\
                        '<h1 class="text-4xl font-bold text-center mb-4">Bem vindo a sua aplicação Python!</h1>'\
                        '<p class="text-lg text-gray-700 text-center">Isso é apenas um exemplo do potencial do python, é possivel explorar muito mais do que isso.</p>'\
                        '</div>'\
                    '</body>'\
                    '</html>'

    # Codificando a resposta
    resposta_bytes = resposta_http.encode('utf-8')

    # Enviando a resposta
    conexao.sendall(resposta_bytes)

    # Fechando a conexão
    conexao.close()

# Fechando o socket
servidor.close()
