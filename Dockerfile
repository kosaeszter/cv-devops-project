FROM node:18-slim AS builder
WORKDIR /src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm prune --production 

FROM node:18-slim
WORKDIR /src/app
COPY --from=builder /src/app/node_modules ./node_modules
COPY --from=builder /src/app/main.js .
EXPOSE 3000
CMD ["node", "main.js"]