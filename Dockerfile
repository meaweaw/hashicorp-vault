# Use the official Vault Docker image
FROM hashicorp/vault:latest

# Set build-time variables
ARG VAULT_ADDR
ARG VAULT_API_ADDR

# Set environment variables based on the arguments
ENV VAULT_ADDR=${VAULT_ADDR}
ENV VAULT_API_ADDR=${VAULT_API_ADDR}

# Create configuration directory
RUN mkdir -p /vault/config

# Copy your custom Vault configuration file into the Docker image
COPY vault-config.hcl /vault/config/vault-config.hcl

# Expose the Vault port
EXPOSE 8200

# Start Vault server with your custom configuration file
CMD ["vault", "server", "-config=/vault/config/vault-config.hcl"]