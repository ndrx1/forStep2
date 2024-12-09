FROM node:14

# Встановлюємо робочий каталог всередині контейнера
WORKDIR /app

# Перевірка версії Node.js та npm
RUN node -v
RUN npm -v

# Копіюємо package.json і package-lock.json (якщо є) для залежностей
COPY package*.json ./

# Встановлюємо залежності
RUN npm install --include=dev
RUN npm install -g jest
RUN npm list supertest

# Копіюємо решту коду програми
COPY . .

# Відкриваємо порт, на якому працюватиме ваш додаток
EXPOSE 3000

# Перевірка версії jest
RUN npx jest --version

# Встановлюємо команду для запуску додатку
CMD ["npm", "start"]
