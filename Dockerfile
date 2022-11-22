FROM node:16-alpine as base
WORKDIR /app

FROM base as dependencies-prod
COPY ["package.json", "yarn.lock", "./"]
RUN yarn install --production=true --frozen-lockfile

FROM base as final
ENV NODE_ENV=production
COPY --from=dependencies-prod /app/node_modules ./node_modules
COPY src .
CMD ["node", "index.js"]
