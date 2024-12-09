FROM node:14

WORKDIR /app

# Копіюємо package.json та package-lock.json, щоб тільки при потребі оновлювати залежності
COPY package*.json ./

RUN npm install

# Копіюємо весь проект
COPY . .

# Запускаємо тести
RUN npm test

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
ENTRYPOINT ["npm", "start"]
