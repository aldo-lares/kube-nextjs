# build
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
 
# env
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app/next.config.mjs ./
COPY --from=build /app/package*.json ./
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
RUN npm install next
EXPOSE 3000
CMD ["npm", "start"]