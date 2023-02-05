<details>
<summary>Introduction</summary>
<br>

  chatGpt
   1. How to write a Full Stack React App of Game connect four with username and password.The app should also keep track of the username and  password in  database using MangoDB?

          Here is an overview of the steps you can follow to create a full-stack React app for the game Connect Four with user authentication using MongoDB:

        Set up your development environment: You'll need to have Node.js, npm, and a code editor installed.

        Create a new React app: You can use the create-react-app command to generate a new React project.

        Design the user interface: Create a UI for the Connect Four game, including the game board, player pieces, and controls for making moves.

        Implement the game logic: Write code to handle the rules of Connect Four, such as determining a win or a draw.

        Set up user authentication: Implement a login and registration system for users to create an account and log in to the app.

        Store user information in a database: Use MongoDB to store user information, including usernames and passwords.

        Connect the front-end and back-end: Use Axios or another HTTP client library to send HTTP requests to the back-end to perform operations such as logging in or creating an account.

        Deploy the app: Deploy the full-stack React app to a hosting platform such as Heroku or AWS.

        Note: These are just the general steps, and the specific implementation details will depend on your preferences and the requirements of your project. Before starting, you may want to consider learning the basics of React, MongoDB, and full-stack development.




  
  
</details>


<details>
<summary>Installation and setup</summary>
<br>
  
  ```
    react $ mkdir fullstack-app
    react $ cd fullstack-app/
    fullstack-app $ npm init -y
  ```

    Here is a step-by-step process to create a new React app using the create-react-app command:

    Open your terminal or command prompt.

    Install create-react-app globally by running the following command: npm install -g create-react-app

    Create a new React project by running the following command: npx create-react-app my-app, replacing "my-app" with the name of your desired project.

    Change into the project directory by running the following command: cd my-app

    Start the development server by running the following command: npm start

    Your default browser should open to http://localhost:3000 and you should see the default React app running.

    Now you have a new React app set up and ready to go. You can start building your Connect Four game by following the next steps in the process.

  
</details>


<details>
<summary>Setup Backend first - with - Express</summary>
<br>

    set up a back-end server for a game app with Node.js using Express
  
  ```
  fullstack-app $ npm install express
  
  
  
     Here's how you can set up a back-end server for your game app using Node.js and Express:

    Install Node.js: If you don't already have Node.js installed on your system, download and install it from the official website.

    Create a new Node.js project: Open your terminal or command prompt and navigate to the directory where you want to store your project. Run the following command to create a new Node.js project: npm init -y

    Install Express: Express is a popular web framework for Node.js. To install it, run the following command: npm install express

    Create an Express app: Create a new file named index.js and add the following code to set up an Express app:
  
      const express = require('express');
      const app = express();

      app.get('/', (req, res) => {
          res.send('Hello World!');
      });

      app.listen(3000, () => {
          console.log('Server listening on port 3000');
      });

      Start the server: To start the server, run the following command in your terminal or command prompt: node index.js. You should see the message Server listening on port 3000 in the console, indicating that your server is running.

    Test the server: Open your web browser and go to http://localhost:3000. You should see the message Hello World! displayed on the page.

    Now you have a basic Express app set up and running on your local machine. From here, you can add routes, controllers, and models to handle the data for your game app.
  
  ```
  
  
  
</details>


<details>
<summary>Setup MongoDB </summary>
<br>

  what is mongoDB and how do we setup a database online with it 
  
          ```
          MongoDB is a NoSQL, cross-platform, document-oriented database. It is known for its scalability, high performance, and flexibility, making it a popular choice for modern web applications.

        To set up a MongoDB database online, you can follow these steps:

        Sign up for a MongoDB account: Go to the MongoDB website and create a new account.

        Create a new cluster: Once you have signed in, you can create a new cluster by clicking the "Build a Cluster" button.

        Configure the cluster: In this step, you can choose the region where your cluster will be located, the size of your cluster, and any other options you may want to configure.

        Connect to your cluster: After your cluster is set up, you will be given a connection string that you can use to connect to your cluster. You can use this connection string in your application code to access the database.

        Load data into your database: You can load data into your database using the MongoDB shell or by writing code in your application that inserts data into the database.

        That's it! You now have a MongoDB database up and running in the cloud, ready for you to use in your applications. If you need more information or assistance, you can refer to the MongoDB documentation for detailed instructions and guidance.

  
  
   <img width="1227" alt="image" src="https://user-images.githubusercontent.com/75510135/216752411-b85b30c7-c85c-4686-99ae-6a19294d6556.png">

   <img width="1027" alt="image" src="https://user-images.githubusercontent.com/75510135/216752456-090c29ed-cfca-4517-8496-c23e57c91bb1.png">
   <img width="1094" alt="image" src="https://user-images.githubusercontent.com/75510135/216752476-81177d17-f8ae-4d78-b0ca-c27e5e726ad6.png">

    
     
</details>


<details>
<summary>Connect Express Server to MongoDB via Mongoose Library</summary>
<br>

  
  Connect our express server to mongodb database using the mongoose library
  
     ```
          To connect your Express server to a MongoDB database using the Mongoose library, you can follow these steps:

          Install Mongoose: Run the following command in your terminal or command prompt to install Mongoose: npm install mongoose

          Connect to the database: In your Express app, require the Mongoose library and connect to your database using the following code:

            const mongoose = require('mongoose');

          mongoose.connect('mongodb://<username>:<password>@<cluster>.mongodb.net/<database>', {
            useNewUrlParser: true,
            useUnifiedTopology: true
          });

          const db = mongoose.connection;

          db.on('error', console.error.bind(console, 'connection error:'));
          db.once('open', function() {
            console.log("Connected to MongoDB");
          });


            Note that you need to replace <username>, <password>, <cluster>, and <database> with the appropriate values for your database.

          Define a Mongoose model: In Mongoose, a model is a blueprint for a document in your database. To define a model, you can create a new file in your Express app and add the following code:

            const mongoose = require('mongoose');

          const userSchema = new mongoose.Schema({
            username: String,
            password: String
          });

          const User = mongoose.model('User', userSchema);


            In this example, we're defining a model for a user with a username and password.

          Use the model in your routes: Now that you have a model defined, you can use it in your Express routes to interact with your MongoDB database. For example:


            app.post('/register', (req, res) => {
            const user = new User({
              username: req.body.username,
              password: req.body.password
            });

            user.save((error) => {
              if (error) {
                res.send(error);
              } else {
                res.send("User registered successfully");
              }
            });
          });

            In this example, we're using the save method to insert a new user into the database.

          And that's it! You now have your Express server connected to your MongoDB database using Mongoose. You can use Mongoose to perform CRUD                 operations on your database, validate data, and more.
  

         Alternatively => chatgpt => write async function to connect mongodb via mongoose library
  

      const mongoose = require('mongoose');

      async function connectToMongoDB() {
        try {
          await mongoose.connect('mongodb://<username>:<password>@<cluster>.mongodb.net/<database>', {
            useNewUrlParser: true,
            useUnifiedTopology: true
          });
          console.log("Connected to MongoDB");
        } catch (error) {
          console.error("Error connecting to MongoDB:", error);
        }
      }

      Note that you need to replace <username>, <password>, <cluster>, and <database> with the appropriate values for your database.

    You can call this function in your Express app to connect to your MongoDB database. For example:

      connectToMongoDB().then(() => {
      // Your app code goes here
    });

  
  <img width="690" alt="image" src="https://user-images.githubusercontent.com/75510135/216756249-f28df47b-60a5-4550-8573-608193160ee9.png">

  <img width="683" alt="image" src="https://user-images.githubusercontent.com/75510135/216756266-c44eff5b-540e-4cad-9a89-70254a78fb5a.png">
  
  
      const mongoose = require("mongoose");
      const Schema = mongoose.Schema;

      const userSchema = new Schema({
        username: { type: String, required: true },
        password: { type: String, required: true }
      });

      const User = mongoose.model("User", userSchema);

      const newUser = new User({
        username: "john",
        password: "password"
      });

      newUser.save((error) => {
        if (error) {
          console.error(error);
        } else {
          console.log("User saved successfully");
        }
      });

  
 
</details>

  
  

<details>
<summary>Frontend - Create basic React App</summary>
<br>

build a frontend with React to our express and mongodb app code above in order to add users to passwords to our databases securely and test that it works

  <img width="492" alt="image" src="https://user-images.githubusercontent.com/75510135/216757258-0565735d-e894-49f9-aa67-753cf5d4d1db.png">

  fullstack-app $ npm install react react-dom
  
  fullstack-app $ npm install -g create-react-app
  
  <img width="683" alt="image" src="https://user-images.githubusercontent.com/75510135/216757675-76f49c2e-275a-4afb-a3b6-889fa24df3ba.png">

  npx create-react-app my-app

  <img width="526" alt="image" src="https://user-images.githubusercontent.com/75510135/216757863-7bd40fcc-4589-4b39-9412-65f567376984.png">

  
  
</details>
  
  
 
<details>
<summary>FE- Create Form-CReate Event Handler</summary>
<br>
  
  <img width="663" alt="image" src="https://user-images.githubusercontent.com/75510135/216760184-f152e6e1-65cb-4ce4-a39d-ae0d371c7810.png">

      import React, { useState } from "react";

    const App = () => {
      const [username, setUsername] = useState("");
      const [password, setPassword] = useState("");

      // const handleSubmit = async (event) => {
      //   event.preventDefault();
      //   const response = await fetch("/api/users", {
      //     method: "POST",
      //     headers: { "Content-Type": "application/json" },
      //     body: JSON.stringify({ username, password }),
      //   });
      //   const result = await response.json();
      //   if (result.error) {
      //     console.error(result.error);
      //   } else {
      //     console.log("User added successfully");
      //   }
      // };

      const handleUserNameChange = (event) => {
        setUsername(event.target.value)
        console.log(username)
      }

      const handlePasswordChange = (event) => {
        setPassword(event.target.value)
      }

      return (
        //onSubmit={handleSubmit}
        <div className="App">
          <h1>Welcome to Game!!!</h1>
        <form >
          <label htmlFor="username">Username:</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={handleUserNameChange}
          />
          <label htmlFor="password">Password:</label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={handlePasswordChange}
          />
          <button type="submit">Add User</button>
        </form>
        </div>
      );
    };

    export default App;



  
</details>
  
  

<details>
<summary>Form Submit- send username n password to database</summary>
<br>

  <img width="621" alt="image" src="https://user-images.githubusercontent.com/75510135/216767979-8da0dae1-cc25-4022-8491-e910724d5922.png">

  <img width="531" alt="image" src="https://user-images.githubusercontent.com/75510135/216768079-de864d80-74de-4121-8163-1ebf0b961eb7.png">
  
  <img width="553" alt="image" src="https://user-images.githubusercontent.com/75510135/216772680-9ec570f4-2170-48d3-b2c9-275c628482a1.png">

  <img width="558" alt="image" src="https://user-images.githubusercontent.com/75510135/216772705-3494e9e1-c144-454d-8b4e-5e09f23c6822.png">

  <img width="583" alt="image" src="https://user-images.githubusercontent.com/75510135/216772712-b3cde1ac-99b7-4188-828a-697fd47fd566.png">

  <img width="562" alt="image" src="https://user-images.githubusercontent.com/75510135/216772726-835d08a1-83ab-424f-8dc5-5f43bf419362.png">

          const express = require('express');
        const app = express();

        const mongoose = require('mongoose');
        const cors = require('cors');

        app.use(cors());
        app.use(express.json());


        const uri = 'mongodb+srv://dbadmin:yehtohonahetha@cluster0.4kv2mjn.mongodb.net/?retryWrites=true&w=majority'

          function connectToMongoDB() {
          try {
             mongoose.connect(uri, {
              useNewUrlParser: true,
              useUnifiedTopology: true
            });
          } catch (error) {
            console.error("Error connecting to MongoDB:", error);
          }
        }

         connectToMongoDB();

          // create a model


          const userSchema = new mongoose.Schema({
            username: String,
            password: String
          });

        const User = mongoose.model('User', userSchema);


        app.get('/', (req, res) => {
            res.send('Hello World!');
        });

        // POST endpoint to add a new user
        app.post('/', async (req, res) => {
            try {
              const {username, password} = req.body;
              const user = new User({username, password});
              const result = await user.save();
              res.send({ message: 'User added successfully', result });
            } catch (error) {
              res.status(500).send({ error: error.message });
            }
          });


        app.listen(3000, () => {
            console.log('Server listening on port 3000');
        });
  
  
</details>
  


<details>
<summary>FE - Add routing </summary>
<br>

  <img width="570" alt="image" src="https://user-images.githubusercontent.com/75510135/216776439-5e1cdd29-18b3-40a4-b0f1-d3692b22e450.png">

  <img width="558" alt="image" src="https://user-images.githubusercontent.com/75510135/216776773-84b14168-0f21-49e0-bd22-60c732ea9e3b.png">

  <img width="574" alt="image" src="https://user-images.githubusercontent.com/75510135/216777207-1606eabd-3f16-4ca3-bafc-0eb4ca4f26a7.png">

  <img width="481" alt="image" src="https://user-images.githubusercontent.com/75510135/216777805-6abe27ca-782a-4e21-8353-eca404cfc9d3.png">

  <img width="489" alt="image" src="https://user-images.githubusercontent.com/75510135/216777791-7616c089-8130-4728-816e-bfee0f2dfda4.png">

  
  
</details>
  
  
  
<details>
<summary>Routing to Welcome Page</summary>
<br>

    <img width="627" alt="image" src="https://user-images.githubusercontent.com/75510135/216799741-eae2a2da-7c20-4e38-8bca-04631f5e8b30.png">

  
  <img width="564" alt="image" src="https://user-images.githubusercontent.com/75510135/216799750-d79fed89-40bd-444b-a981-563f7bff2c34.png">

  <img width="574" alt="image" src="https://user-images.githubusercontent.com/75510135/216799758-4587ff52-4376-4e60-92a6-7016f4429134.png">

  
  
</details>
  

<details>
<summary>Title</summary>
<br>


  
</details>
  
  
  
<details>
<summary>Title</summary>
<br>


  
</details>
  
  
  
