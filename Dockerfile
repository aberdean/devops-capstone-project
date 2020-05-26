# hadolint ignore=DL3006
FROM nginx

## Step 1:
# Remove nginx original HTML file
RUN rm /usr/share/nginx/html/index.html

## Step 2:
# Copy project HTML file
COPY index.html /usr/share/nginx/html
