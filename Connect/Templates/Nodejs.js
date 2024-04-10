const http = require('http');
const args = process.argv.join(" ");
console.log(args);
const port = args.slice(args.indexOf(" -port ") + 7).split(" ")[0];

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/html' });
  const logo = "https://cdn.discordapp.com/attachments/1219231279111868509/1227711128684068954/pngegg_1.png?ex=66296616&is=6616f116&hm=554de848ae4ac7181256eda0899b78f97609977212c58666869f06ce575cd640&"
  const content = `
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aplicação Node JS</title>
    <link rel="shortcut icon" href="${logo}" type="image/png" style="border-radius: 50px;">
    <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
  </head>
  <body class="bg-gray-100">
    <div class="flex justify-center items-center flex-col mx-auto px-4 py-8">
      <img class="w-36 h-36" src="${logo}"/>
      <h1 class="text-4xl font-bold text-center mb-4">Bem vindo a sua aplicação NODE JS!</h1>
      <p class="text-lg text-gray-700 text-center">Isso é apenas um exemplo do potencial do node js, é possivel explorar muito mais do que isso.</p>
    </div>
  </body>
  </html>  
`;
  res.end(content);
});

server.listen(port, () => {
  console.log('Servidor escutando na porta '+ port);
});
