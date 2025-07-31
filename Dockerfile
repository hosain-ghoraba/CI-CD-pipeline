# syntax=docker/dockerfile:1


ARG NODE_VERSION=22.17.1

FROM node:${NODE_VERSION}-alpine

# Use production mode
ENV NODE_ENV=production

WORKDIR /usr/src/app

# Install curl (to be used by the container in healthchecks in part 3)
RUN apk add --no-cache curl

# Leverage a cache mount to /root/.npm to speed up subsequent builds.
# Leverage a bind mounts to package.json and package-lock.json to avoid having to copy them into
# into this layer.
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

# Run as non-root
USER node

# Copy the rest
COPY . .

EXPOSE 4000

CMD ["npm", "start"]
