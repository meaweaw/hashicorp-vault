#!/bin/sh

# Add custom capability handling or other setup here
echo "Running entrypoint script..."

# Run the Vault server
exec vault server -config=/vault/config/vault-config.hcl