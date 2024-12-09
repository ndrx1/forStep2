FROM node:14

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Expose the port the app runs on
EXPOSE 3000

ENTRYPOINT ["npm", "start"]
# Define the command to run the app


