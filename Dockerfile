# hadolint ignore=DL3006
FROM nginx:1.17.10

# Copy project HTML file
COPY index.html /usr/share/nginx/html
