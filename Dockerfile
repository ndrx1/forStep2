FROM node:14

# Встановлюємо робочий каталог всередині контейнера
WORKDIR /app

# Копіюємо package.json і package-lock.json (якщо є) для залежностей
COPY package*.json ./

# Встановлюємо залежності
RUN npm install

# Копіюємо решту коду програми
COPY . .

# Відкриваємо порт, на якому працюватиме ваш додаток
EXPOSE 3000

RUN npx jest --version

# Встановлюємо команду для запуску додатку
CMD ["npm", "start"]
