# Use the official Vault Docker image
FROM hashicorp/vault:latest

# Set build-time variables
ARG VAULT_ADDR
ARG VAULT_API_ADDR

# Set environment variables based on the arguments
ENV VAULT_ADDR=${VAULT_ADDR}
ENV VAULT_API_ADDR=${VAULT_API_ADDR}

# Create the configuration directory
RUN mkdir -p /vault/config

# Copy the Vault configuration file into the container
COPY vault-config.hcl /vault/config/vault-config.hcl

# Ensure the entrypoint script is executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Change the working directory
WORKDIR /app

# Set up a volume for persistent data (adjust paths as needed)
VOLUME ["/vault/config", "/vault/data"]

# Expose the Vault port
EXPOSE 8200

# Use the entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]