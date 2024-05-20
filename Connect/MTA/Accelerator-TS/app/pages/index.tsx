import ReactDOM from "react-dom/server";

export function Html() {
  const logo = "https://cdn.discordapp.com/attachments/1033486312956768336/1239420224802127942/mta.png?ex=6642db88&is=66418a08&hm=df145c3a8bfea423b02c5dc008671f175966c1dddc5b4955a7746a063e5fb25f&";
  
  const html = ReactDOM.renderToString(
    <html lang="en">
      <head>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Accelerator Resources</title>
        <link rel="shortcut icon" href={logo} type="image/png" style={{ borderRadius: '50px' }} />
        <script src="https://cdn.tailwindcss.com"></script>
      </head>
      <body className="bg-black">
        <div className="flex justify-center items-center flex-col mx-auto px-4 py-8">
          <img className="w-36 h-36" src={logo} alt="Logo" />
          <h1 className="text-4xl text-white font-bold text-center mb-4">Download Accelerator</h1>
          <p className="text-lg text-gray-300 text-center">This port is currently being used to improve your experience on the server!.</p>
        </div>
      </body>
    </html>
  );

  return html;
}
