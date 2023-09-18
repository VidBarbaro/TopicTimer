# TopicTimer Website

## Project Setup
To make sure everything is ready to be deployed you have to install all the dependencies. You can do this by running:
```sh
npm install
```
or 
```sh
npm i
```

### Compile and Hot-Reload for Development
If all the depencies have been installed, you can start a development session by running the following command:
```sh
npm run dev
```
This command will open the project in a localhost environment. Once you save a file in your editor it will be automatically reloaded in the localhost session.

### Compile and Minify for Production
Once you feel like your project is ready to be deployed you can run:
```sh
npm run build
```
This will build the entire project into the 'dist' folder. You can copy everything inside this folder and deploy it wherever you desire.

### Run Unit Tests with [Vitest](https://vitest.dev/)
Not in use for now.
```sh
npm run test:unit
```
